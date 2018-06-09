name := "Succinct Project"

version := "1.0"

scalaVersion := "2.10.5"

resolvers += "Spark Packages Repo" at "http://dl.bintray.com/spark-packages/maven"

libraryDependencies += "org.apache.spark" %% "spark-core" % "2.0.0"
libraryDependencies += "amplab" % "succinct" % "0.1.7"
