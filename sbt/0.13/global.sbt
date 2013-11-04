import AssemblyKeys._

assemblySettings

seq(Revolver.settings: _*)

net.virtualvoid.sbt.graph.Plugin.graphSettings

shellPrompt := { state =>
  "sbt (%s)> ".format(Project.extract(state).currentProject.id)
}

lazy val mkdirs = taskKey[Unit]("Creates project directory structure")

mkdirs := {
    val directories = for {
      dir1 <- Seq("main", "test")
      dir2 <- Seq("scala", "java", "resources")
    } yield baseDirectory.value / "src" / dir1 / dir2
    IO.createDirectories(directories)
    println("Project directory structure created")
}
