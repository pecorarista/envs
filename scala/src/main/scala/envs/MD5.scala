package envs

import java.io.{ File, FileInputStream }
import java.security.MessageDigest

object MD5 {

  implicit class Hash(f: File) {

    def md5(): String = {

      val md = MessageDigest.getInstance("MD5");
      val is = new FileInputStream(f);
      val bufferSize = 1024;
      var buffer = new Array[Byte](bufferSize);
      var read = 0;
      read = is.read(buffer)
      while (read > 0) {
        md.update(buffer, 0, read);
        read = is.read(buffer)
      }
      md.digest.map(b => "%02x".format(b)).mkString.toLowerCase
    }

  }

}
