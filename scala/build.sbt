name := "envs"

version := "1.0"

lazy val root = (project in file("."))

scalaVersion := "2.11.8"

sbtVersion := "0.13.11"

scalacOptions ++= Seq("-deprecation", "-feature", "-unchecked", "-Xlint", "-Ywarn-unused-import")

scalacOptions in (Compile, console) ~= (_ filterNot (_ == "-Ywarn-unused-import"))
