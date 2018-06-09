/* ExperimentApp.scala */
import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.storage.StorageLevel
import org.apache.spark.SparkConf
import edu.berkeley.cs.succinct._
import edu.berkeley.cs.succinct.kv._
import org.apache.spark.util.SizeEstimator
import org.apache.log4j.{Level, Logger}

import scala.collection.mutable.ArrayBuffer
import scala.util.Random

object SuccinctApp {

  def main(args: Array[String]) {

    val uri = new Array[String](8)
    uri(0) = "s3n://succinct-datasets/smallkv/10GB/data_0"
    uri(1) = "s3n://succinct-datasets/smallkv/10GB/data_1"
    uri(2) = "s3n://succinct-datasets/smallkv/10GB/data_2"
    uri(3) = "s3n://succinct-datasets/smallkv/10GB/data_3"
    uri(4) = "s3n://succinct-datasets/smallkv/5GB/data_4"
    uri(5) = "s3n://succinct-datasets/smallkv/5GB/data_5"
    uri(6) = "s3n://succinct-datasets/smallkv/5GB/data_6"
    uri(7) = "s3n://succinct-datasets/smallkv/5GB/data_7"

    val conf = new SparkConf().setAppName("Succinct Experiment Application")
    val sc = new SparkContext(conf)
    val rootLogger = Logger.getRootLogger()
    rootLogger.setLevel(Level.ERROR)
    val hadoopConf = sc.hadoopConfiguration

    val sparkData = sc.textFile(dataFile)
    val count = sparkData.count().toInt
    val sparkKVData = sparkData.map(_.getBytes).zipWithIndex().map(t => (t._2, t._1))
    val succinctKVRDD = SuccinctKVRDD(sparkKVData).persist()

    val keys = sc.parallelize(Seq.fill(10000)(Random.nextInt(count).toLong))
    val t0 = System.nanoTime()
    keys.map(k => succinctKVRDD.get(k))
    val t1 = System.nanoTime()
    var elapsed = t1 - t0
    println("READTIME  " + elapsed)

    val searchkeys = sc.parallelize(Seq.fill(10000)(Random.nextInt(count).toLong))
    val values = searchkeys.map(x => {
      succinctKVRDD.get(x).toString.split('|')(0).toString
    })

    val t2 = System.nanoTime()
    values.map(v => succinctKVRDD.search(v.getBytes))
    val t3 = System.nanoTime()
    elapsed = t3 - t2
    println("SEARCHTIME  " + elapsed)
  }
}
