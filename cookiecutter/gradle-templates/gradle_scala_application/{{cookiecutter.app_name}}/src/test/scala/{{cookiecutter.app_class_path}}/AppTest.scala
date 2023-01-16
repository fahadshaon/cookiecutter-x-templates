package {{cookiecutter.app_package}}

import org.scalatest.FunSuite
import org.scalatest.junit.JUnitRunner

import org.junit.runner.RunWith

@RunWith(classOf[JUnitRunner])
class AppTest extends FunSuite {

  test("helloTest") {
    val app = new App()
    assert(app.hello() == "Hello World")
  }
}
