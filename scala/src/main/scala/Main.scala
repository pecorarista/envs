import com.typesafe.config.ConfigFactory

import envs.Anaconda

object Main extends App {

  require(args.length == 0 || args.length == 1)

  val prefix = if (args.length == 1) args(0).split('=')(1) else sys.env("HOME")

  (2 to 3).foreach { version =>
    val install = ConfigFactory.load.getBoolean(s"anacondas.anaconda$version.install")
    if (install) Anaconda.install(prefix = prefix, version = version)
  }

}
