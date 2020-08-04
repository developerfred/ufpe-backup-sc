/*
 *Primeira parte do Projeto de IP
 *Classe: IDocente
 */

package docente;

import java.util.*; 

/**
 * @author Aluísio Rodrigo Fonseca de Santana - arfs
 * @author Henrique Seabra Diniz - hsd
 */
public interface IDocente {
	public void inserirDocente(Docente d);
	public void removerDocente(String n);
	public Docente procurarDocente(String n);
	public boolean existeDocente(String n);
	public void alterarDocente(Docente d);
	public Vector getVectorDocentes();
	public Iterator getIterator();
}
