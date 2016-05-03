package envs

import java.io.File
import java.net.URL

import scala.language.postfixOps

import sys.process._

import com.typesafe.config.ConfigFactory

import envs.MD5._

object Anaconda {

  private def filenameOf(path: String) = {
    val f = new File(path)
    f.getName
  }

  private def versionCheck(python: File, versionMessage: String): Boolean = {
    if (python.exists) {
      val stdout = new StringBuilder
      val stderr = new StringBuilder
      (python.getPath + " --version") ! ProcessLogger(stdout append _, stderr append _)
      stderr.toString.trim == versionMessage
    } else false
  }

  def install(prefix: String, version: Int, update: Boolean = false, downloadNLTK: Boolean = true): Unit = {

    require(version == 2 || version == 3)

    val config = ConfigFactory.load()

    val anacondaHome = s"$prefix/anaconda$version"
    val python = new File(s"$anacondaHome/bin/python")
    val versionMessage = config.getString(s"anacondas.anaconda$version.version")

    if (versionCheck(python, versionMessage)) {
      println(s""""$versionMessage" already exists at $anacondaHome""")
    } else {
      val url = new URL(config.getString(s"anacondas.anaconda$version.installer.url"))

      val dir = new File(s"$prefix/.install")
      val installer = new File(dir.getPath + "/" + filenameOf(url.getFile))

      val expectedMD5Hash = config.getString(s"anacondas.anaconda$version.installer.md5")

      val hasInstaller = if (installer.exists) installer.md5 == expectedMD5Hash else false

      if (!hasInstaller) {
        if (!dir.exists) dir.mkdirs()
        println("Downloading " + installer.getName)
        url #> installer !
      }

      println("Installing " + installer.getName)
      if (!python.exists) {
        s"bash ${installer.getPath()} -b -p $anacondaHome" !
      }
    }

  }

}
