package {{cookiecutter.app_package}}

object App {

  def main(args: Array[String]): Unit = {
    println(new App().hello())
  }
}

class App {
  def hello(): String = {
    "Hello World"
  }
}
