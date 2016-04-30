import envs.Anaconda

object Main extends App {

  val prefix = args(0)
  Anaconda.install(prefix = prefix, version = 2)

}
