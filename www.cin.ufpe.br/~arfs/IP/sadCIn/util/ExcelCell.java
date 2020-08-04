package util;

import org.apache.poi.hssf.usermodel.HSSFCell;

public class ExcelCell {


       private HSSFCell hssfCell;

       public ExcelCell (HSSFCell hssfCell)  throws Exception{
              this.setHSSFCell (hssfCell);
       }

       protected void setHSSFCell (HSSFCell hssfCell) throws Exception{
            
            if (hssfCell != null) {
                this.hssfCell = hssfCell;
            } else {
                String texto = "Exception: Null reference to HSSFCell ...";
                texto = texto + "\tIn method \"setHSSFCell\" of class \"ExcelCell\".";
            	throw new Exception(texto); 
            }
            
        }

        public double getNumericCellValue () throws Exception {
            double ret = 0.0;

                try {
                	ret = this.hssfCell.getNumericCellValue ();
                }catch(Exception e){ 
                	String msn = "Exception: Getting number from non-numeric Cell ...";
                	msn = msn + "\tIn method \"getNumericCellValue\" of class \"ExcelCell\": " + e.getMessage();
                	throw new Exception (msn);
                }
            	return ret;
           }

        public String getStringCellValue ()throws Exception {
            String ret = "";
            try{
                ret = this.hssfCell.getStringCellValue ();
            } catch (Exception e){
                String msn = "Exception: Getting String from numeric Cell ...";
                msn = msn + "\tIn method \"getStringCellValue\" of class \"ExcelCell\"." + e.getMessage();
                throw new Exception (msn);
            }

            return ret;
        
        }
} // fim da classe

