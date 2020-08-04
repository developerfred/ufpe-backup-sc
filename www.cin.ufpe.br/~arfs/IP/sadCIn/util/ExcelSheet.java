package util;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;

public class ExcelSheet {


       private HSSFSheet hssfSheet;

       public ExcelSheet (HSSFSheet hssfSheet) throws Exception{
              this.setHSSFSheet (hssfSheet);
       }

       protected void setHSSFSheet (HSSFSheet hssfSheet) throws Exception{
            
            if (hssfSheet != null) {
                this.hssfSheet = hssfSheet;
            } else {
                String msn = "Exception: Null reference to HSSFSheet ..." ;
            	msn = msn + "\tIn method \"setHSSFSheet\" of class \"ExcelSheet\"" ;
            	throw new Exception (msn);
             }
            
        }

        public ExcelRow getRow (int rownum) throws Exception{
            ExcelRow ret = null;
            HSSFRow tmp = this.hssfSheet.getRow (rownum);

            if (tmp != null) {
                ret = new ExcelRow (tmp);
            } else {
                String msn = "Exception: Getting a not defined Row, \"#" + rownum + "\" ...";   
                msn = msn + "\tIn method \"getRow\" of class \"ExcelSheet\"." ;
            	throw new Exception (msn);
            }

            return ret;
        }

}

