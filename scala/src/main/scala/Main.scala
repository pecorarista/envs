import envs.Anaconda

object Main extends App {

  require(args.length == 2)

  val prefix = args(0).split('=')(1)
  val version = args(1).split('=')(1).toInt

  Anaconda.install(prefix = prefix, version = version)

}
