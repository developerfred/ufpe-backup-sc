package util;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

public class ExcelWorkbook {

	private HSSFWorkbook hssfWorkbook;

	public ExcelWorkbook(String nomeDoArquivo) throws Exception{
		try {
			FileInputStream fis = new FileInputStream(nomeDoArquivo);
			try {
				HSSFWorkbook tmp = new HSSFWorkbook(fis);
				this.setHSSFWorkbook(tmp);
			} catch (IOException e) {
				String msn = "Exception: Problem during file reading ...";
				msn = msn
						+ "\tIn default constructor \"ExcelWorkbook\" of class \"ExcelWorkbook\".";
				throw new Exception(msn);
			}
		} catch (IOException e) {
			String msn = "Exception: Problem during file reading ...";
			msn = msn
					+ "\tIn constructor \"ExcelWorkbook\" of class \"ExcelWorkbook\".";
			throw new Exception(msn);
		}
	}

	public ExcelWorkbook(InputStream s) throws Exception{

		try {
			HSSFWorkbook tmp = new HSSFWorkbook(s);
			this.setHSSFWorkbook(tmp);
		} catch (IOException e) {
			String msn = "Exception: Problem during file reading ...";
			msn = msn
					+ "\tIn default constructor \"ExcelWorkbook\" of class \"ExcelWorkbook\".";
			throw new Exception(msn);
		}

	}

	protected void setHSSFWorkbook(HSSFWorkbook hssfWorkbook) throws Exception {

		if (hssfWorkbook != null) {
			this.hssfWorkbook = hssfWorkbook;
		} else {
			String msn = "Exception: Null reference to HSSFWorkbook ...";
			msn = msn
					+ "\tIn method \"setHSSFWorkbook\" of class \"ExcelWorkbook\".";
			throw new Exception(msn);
		}

	}

	public ExcelSheet getSheet(String name) throws Exception {
		ExcelSheet ret = null;
		HSSFSheet tmp = this.hssfWorkbook.getSheet(name);

		if (tmp != null) {
			ret = new ExcelSheet(tmp);
		} else {
			String msn = "Exception: Getting a not defined Sheet, \"" + name
					+ "\" ...";
			msn = msn
					+ "\tIn method \"getSheet\" of class \"ExcelWorkbook\".";
			throw new Exception(msn);
		}

		return ret;
	}

}

