lazy val mkdirs = taskKey[Unit]("Creates maven-style project directory structure")

mkdirs := {
  val directories = for {
    dir1 <- Seq("main", "test")
    dir2 <- Seq("scala", "resources")
  } yield baseDirectory.value / "src" / dir1 / dir2

  IO.createDirectories(directories)
  println("Project directory structure created")
}

initialize := {
  val ansi = System.getProperty("sbt.log.noformat", "false") != "true"
  if (ansi) System.setProperty("scala.color", "true")
}

//libraryDependencies += "com.lihaoyi" % "ammonite" % "1.0.3-33-2d70b25" % Test cross CrossVersion.full
//
//sourceGenerators in Test += Def.task {
//  val file = (Test / sourceManaged).value / "amm.scala"
//  IO.write(file, """object amm extends App { ammonite.Main.main(args) }""")
//  Seq(file)
//}.taskValue
