/*
 *Primeira parte do Projeto de IP
 *Classe: NegAlocacao
 */

package alocacao;

import java.util.Vector;

import exceptions.InteiroNegativoException;
import exceptions.JaExisteException;
import exceptions.NaoExisteException;
import exceptions.ObjetoNuloException;

/**
 * @author Aluisio Rodrigo Fonseca de Santana - arfs
 * @author Henrique Seabra Diniz - hsd
 */

public class NegAlocacao {
	private IAlocacao repAlocacao;

	public NegAlocacao() throws Exception{
		this.repAlocacao = new RepAlocacao();
	}

	/**
	 * @return Retorna o atributo arrayAlocacao de um objeto do tipo
	 *         RepAlocacao.
	 */
	public Vector getVectorAlocacao() {
		return repAlocacao.getVectorAlocacao();
	}

	/**
	 * Verifica se os atributos obrigatórios da disciplina estão preenchidos,
	 * verifica se a disciplina já existe e faz a chamada do método da classe de
	 * dados.
	 * 
	 * @param a
	 *            Dados da disciplina a ser inserida no array.
	 */
	public void inserirAlocacao(Alocacao a) throws ObjetoNuloException,
			JaExisteException {
		if ((a != null) && (a.getNomeDisciplina()!= null)
				&& (a.getNomeDisciplina().trim().length()!=0)
				&& (a.getCodigo()!= null)
				&& (a.getCodigo().trim().length()!=0)) {
			if (!repAlocacao.existeAlocacao(a)) {
				int indice = 0;
				if (this.repAlocacao.getVectorAlocacao().isEmpty()) {
					indice = 0;
				} else {
					indice = (this.repAlocacao.getVectorAlocacao()
							.lastIndexOf(this.repAlocacao.getVectorAlocacao()
									.lastElement())) + 1;
				}
				a.setIndice(indice);
				repAlocacao.inserirAlocacao(a);
			} else {
				throw new JaExisteException();
			}
		} else {
			throw new ObjetoNuloException();
		}
	}

	/**
	 * Recebe um inteiro, verifica se o mesmo não é negativo e faz a chamada do
	 * metodo da classe de dados.
	 * 
	 * @param i
	 *            Posição da disciplina no array.
	 */

	public void removerAlocacao(Alocacao alocacao){
		if (alocacao!=null) {
			repAlocacao.removerAlocacao(alocacao);
		}
	}

	/**
	 * Recebe uma String, verifica se a mesma não está vazia e faz a chamada do
	 * método da classe de dados.
	 * 
	 * @param n
	 *            Nome da disciplina a ser removida no array.
	 */
	public Vector procurarAlocacao(String n) throws ObjetoNuloException,
			NaoExisteException {
		Vector retorno = null;
		if ((n!=null) && (n.trim().length()!=0)) {
			retorno = this.repAlocacao.procurarAlocacao(n);
		} else {
			throw new ObjetoNuloException();
		}
		if (repAlocacao == null) {
			throw new NaoExisteException();
		}
		return retorno;
	}

	/**
	 * Recebe ums String, verifica se a mesma não esta vazia, um inteiro,
	 * verifica se o mesmo não é negativo e faz a chamada do método da classe de
	 * dados.
	 * 
	 * @param n
	 *            Nome da disciplina.
	 * @param i
	 *            Tamanho do array das disciplinas.
	 */
	public Vector vectorConjuntoDisciplina(String n) {
		Vector retorno = null;
		if ((n!=null) && (n.trim().length()!=0)) {
			retorno = repAlocacao.vectorConjuntoDisciplina(n);
		}
		return retorno;
	}
}