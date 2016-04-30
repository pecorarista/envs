package envs

import java.io.File
import java.net.URL

import scala.language.postfixOps

import sys.process._

import envs.MD5._

object Anaconda {

  def install(prefix: String, version: Int): Unit = {

    require(version == 2 || version == 3)

    val versionMessage = if (version == 2) "Python 2.7.11 :: Anaconda custom (64-bit)" else "Python 3.5.1 :: Anaconda custom (64-bit)"

    val python = new File(s"$prefix/anaconda${version.toString}/bin/python")
    if (python.exists) {
      val ignore = (s: String) => ""
      var stderr = ""
      prefix + "/bin/python --version" ! ProcessLogger(ignore(_), stderr + _)
      if (stderr == versionMessage) return // scalastyle:ignore
    }

    val installDir = new File(s"$prefix/.install")
    val installer = new File(s"${installDir.getPath()}/Anaconda${version}-4.0.0-Linux-x86_64.sh")
    val url = """http://repo.continuum.io/archive/""" + installer.getName()

    val expectedMD5Hash = if (version == 2) "31ed3ef07435d7068e1e03be49381b13" else "546d1f02597587c685fa890c1d713b51"

    val hasInstaller = if (installer.exists) installer.md5 == expectedMD5Hash else false

    if (!hasInstaller) {
      installDir.mkdirs()
      println(s"Downloading ${installer.getName()}")
      new URL(url) #> new File(s"${installDir.getPath}/${installer.getName()}") !!
    }

    println(s"Installing ${installer.getName()}")
    s"bash ${installer.getPath()} -b -p $prefix/anaconda$version" !

  }

}
