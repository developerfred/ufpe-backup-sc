/*
 * Created on 14/02/2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package exceptions;

/**
 * @author Henrique
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class JaExisteException extends Exception {
	
	public JaExisteException() {
		super();
	}
	
	public String getMessage() {
		return ("Cadastro j� efetuado.");
	}
}
