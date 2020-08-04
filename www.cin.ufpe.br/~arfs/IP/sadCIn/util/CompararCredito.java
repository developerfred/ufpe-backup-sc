/*
 * Created on 15/02/2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package util;

import relatorio.*;
import java.util.*;
import java.math.BigDecimal;

/**
 * @author Henrique
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class CompararCredito implements Comparator {
	
	public CompararCredito() {
	}
	
	public int compare(Object obj1, Object obj2) {
		int i = 0;
		BigDecimal credito1 = ((Relatorio) obj1).getCreditos();
		BigDecimal credito2 = ((Relatorio) obj2).getCreditos();
			
		if (credito1.compareTo(credito2) == -1) {
			i = -1;
		}
		else if (credito1.compareTo(credito2) == 1) {
			i = 1;
		}
		return i;
	}
}
