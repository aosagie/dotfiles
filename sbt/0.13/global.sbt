import AssemblyKeys._

assemblySettings

seq(Revolver.settings: _*)

net.virtualvoid.sbt.graph.Plugin.graphSettings

shellPrompt := { state =>
 "sbt (%s)> ".format(Project.extract(state).currentProject.id)
}
