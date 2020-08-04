/*
 *Primeira parte do Projeto de IP
 *Classe: NegDocente
 */

package docente;

import java.util.Iterator;

import exceptions.JaExisteException;
import exceptions.NaoExisteException;
import exceptions.ObjetoNuloException;

/**
 * @author Aluísio Rodrigo Fonseca de Santana - arfs
 * @author Henrique Seabra Diniz - hsd
 */
public class NegDocente {
	private IDocente repDocente;

	/**
	 * Construtor da classe NegDocente.
	 */
	public NegDocente() throws Exception{
		this.repDocente = new RepDocente();
	}

	public Iterator getIteRepDocente() {
		return this.repDocente.getIterator();
	}

	/**
	 * Verifica se os atributos obrigatórios do docente estão preenchidos,
	 * verifica se o docente já existe e faz a chamada do método da classe de
	 * dados.
	 * 
	 * @param a
	 *            Dados da disciplina a ser inserida no array.
	 */
	public void inserirDocente(Docente d) throws ObjetoNuloException,
			JaExisteException {
		if ((d != null) && (d.getNome() != null)
				&& (d.getNome().trim().length() != 0)
				&& (d.getRegime() != null)
				&& (d.getRegime().trim().length() != 0)) {
			if (!repDocente.existeDocente(d.getNome())) {
				repDocente.inserirDocente(d);
			} else {
				throw new JaExisteException();
			}
		} else {
			throw new ObjetoNuloException();
		}
	}

	/**
	 * Recebe uma String, verifica se a mesma não está vazia e faz a chamada do
	 * metodo da classe de dados.
	 * 
	 * @param n
	 *            Nome do docente.
	 */
	public void removerDocente(String n) throws ObjetoNuloException,
			NaoExisteException {
		if ((n != null) && (n.trim().length() != 0)) {
			if (repDocente.existeDocente(n)) {
				repDocente.removerDocente(n);
			} else {
				throw new NaoExisteException();
			}
		} else {
			throw new ObjetoNuloException();
		}
	}

	/**
	 * Recebe uma String, verifica se a mesma não está vazia e faz a chamada do
	 * metodo da classe de dados.
	 * 
	 * @param n
	 *            Nome do docente.
	 */
	public Docente procurarDocente(String n) throws ObjetoNuloException,
			NaoExisteException {
		Docente docente = null;
		if ((n != null) && (n.trim().length() != 0)) {
			docente = repDocente.procurarDocente(n);
		} else {
			throw new ObjetoNuloException();
		}
		if (docente == null) {
			throw new NaoExisteException();
		}
		return docente;

	}

	/**
	 * Verifica se os atributos obrigatórios do docente estão preenchidos,
	 * 
	 * @param d
	 *            Dados a serem atualizados.
	 */
	public void alterarDocente(Docente d) throws ObjetoNuloException {
		if ((d != null) && (d.getNome() != null)
				&& (d.getNome().trim().length() != 0) && (d != null)
				&& (d.getRegime().trim().length() != 0)) {
			if (repDocente.existeDocente(d.getNome())) {
				repDocente.alterarDocente(d);
			}
		} else {
			throw new ObjetoNuloException();
		}
	}
}