/*
 * Created on 15/02/2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package util;

import java.util.*;
import relatorio.*;

public class CompararNome implements Comparator {
	
	
	public CompararNome() {
	}
	
	public int compare(Object obj1, Object obj2) {
		String nome1 = ((Relatorio) obj1).getDocente().getNome();
		String nome2 = ((Relatorio) obj2).getDocente().getNome();
		return nome1.compareToIgnoreCase(nome2);
	}
}