package util;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;

public class ExcelRow {


       private HSSFRow hssfRow;

       public ExcelRow (HSSFRow hssfRow) throws Exception{
              
              	this.setHSSFRow (hssfRow);
              
       }

       protected void setHSSFRow (HSSFRow hssfRow) throws Exception{

            if (hssfRow != null) {
                this.hssfRow = hssfRow;
            } else {
                String msn = "Exception: Null reference to HSSFRow ...";
                msn = msn + "\tIn method \"setHSSFRow\" of class \"ExcelRow\".";
                throw new Exception (msn);
            }   
        }

        public ExcelCell getCell (short cellnum) throws Exception{
            ExcelCell ret = null;
            HSSFCell tmp = this.hssfRow.getCell (cellnum);

            if (tmp != null) {
                try {
            	ret = new ExcelCell (tmp);
                }catch (Exception e){
                String msn = "Exception: Getting a not defined Cell, \"#" + cellnum + "\" ...";
                msn = msn + "\tIn method \"getCell\" of class \"ExcelRow\".";
                throw new Exception ();
                }
            } 
              
          

            return ret;
        }

}

