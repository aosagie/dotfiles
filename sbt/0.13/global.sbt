import AssemblyKeys._

assemblySettings

Revolver.settings

net.virtualvoid.sbt.graph.Plugin.graphSettings

shellPrompt := { state =>
  import scala.Console.{CYAN, RESET}
  val projectId = Project.extract(state).currentProject.id
  s"sbt ($CYAN$projectId$RESET)> "
}

lazy val mkdirs = taskKey[Unit]("Creates maven-style project directory structure")

mkdirs := {
  val directories = for {
    dir1 <- Seq("main", "test")
    dir2 <- Seq("scala", "java", "resources")
  } yield baseDirectory.value / "src" / dir1 / dir2
  IO.createDirectories(directories)
  println("Project directory structure created")
}
