import sbt._
import Process._
import com.twitter.sbt._

class FlockDBProject(info: ProjectInfo) extends StandardProject(info) with SubversionPublisher with InlineDependencies {
  inline("com.twitter" % "gizzard" % "1.5.9")

  val asm       = "asm" % "asm" %  "1.5.3" % "test"
  val cglib     = "cglib" % "cglib" % "2.1_3" % "test"
  val hamcrest  = "org.hamcrest" % "hamcrest-all" % "1.1" % "test"
  val jmock     = "org.jmock" % "jmock" % "2.4.0" % "test"
  val objenesis = "org.objenesis" % "objenesis" % "1.1" % "test"
  val specs     = "org.scala-tools.testing" % "specs" % "1.6.2.1" % "test"

  override def subversionRepository = Some("http://svn.local.twitter.com/maven-public/")
}
