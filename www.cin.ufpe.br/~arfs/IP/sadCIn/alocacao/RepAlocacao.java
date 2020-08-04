/*
 *Primeira parte do Projeto de IP
 *Classe: RepAlocacao
 */

package alocacao;

import java.math.BigDecimal;
import java.util.*;

import util.ExcelCell;
import util.ExcelRow;
import util.ExcelSheet;
import util.ExcelWorkbook;

/**
 * @author Aluisio Rodrigo Fonseca de Santana - arfs
 * @author Henrique Seabra Diniz - hsd
 */

public class RepAlocacao implements IAlocacao {

	private Vector vectorAlocacao;

	/**
	 * Contrutor da classe RepAlocacao.
	 */
	public RepAlocacao() throws Exception {
		this.vectorAlocacao = new Vector();
		init();
	}

	private synchronized void init() throws Exception {
		ExcelWorkbook arqXlsAlocacao = new ExcelWorkbook(
				"H:\\IP\\Alocacao2003-2.xls");
		ExcelSheet planilhaAlocacao = arqXlsAlocacao.getSheet("Alocacao2003-2");
		ExcelCell conteudo;
		String nomeDisciplina = "";
		String codigo = "";
		String endInternet = "";
		double numDeCredito = 0.0;
		String disciplinaConjunto = "";
		String infoDisciplina = "";
		String professor1 = "";
		String professor2 = "";
		String professor3 = "";

		for (int cont = 1; cont < 132; cont = cont + 1) {
			ExcelRow linha = planilhaAlocacao.getRow(cont);
			if (linha.getCell((short) 0) == null) {
				
			} else {
				conteudo = linha.getCell((short) 0);
				nomeDisciplina = conteudo.getStringCellValue();
			}

			if ((linha.getCell((short) 2) == null)
					|| (linha.getCell((short) 2).getStringCellValue()
							.equals(""))
					|| (linha.getCell((short) 2).getStringCellValue()
							.equals(" "))) {
				professor1 = "";
			} else {
				conteudo = linha.getCell((short) 2);
				professor1 = conteudo.getStringCellValue();
			}

			if ((linha.getCell((short) 3) == null)
					|| (linha.getCell((short) 3).getStringCellValue()
							.equals(""))
					|| (linha.getCell((short) 3).getStringCellValue()
							.equals(" "))) {
				professor2 = "";
			} else {
				conteudo = linha.getCell((short) 3);
				professor2 = conteudo.getStringCellValue();
			}

			if ((linha.getCell((short) 4) == null)
					|| (linha.getCell((short) 4).getStringCellValue()
							.equals(""))
					|| (linha.getCell((short) 4).getStringCellValue()
							.equals(" "))) {
				professor3 = "";
			} else {
				conteudo = linha.getCell((short) 4);
				professor3 = conteudo.getStringCellValue();
			}

			if (linha.getCell((short) 5) == null) {
				numDeCredito = 0.0;
			} else {
				conteudo = linha.getCell((short) 5);
				numDeCredito = conteudo.getNumericCellValue();
			}

			if ((linha.getCell((short) 10) == null)
					|| (linha.getCell((short) 10).getStringCellValue()
							.equals(""))
					|| (linha.getCell((short) 10).getStringCellValue()
							.equals(" "))) {
				disciplinaConjunto = "";
			} else {
				conteudo = linha.getCell((short) 10);
				disciplinaConjunto = conteudo.getStringCellValue();
			}

			if ((linha.getCell((short) 13) == null)
					|| (linha.getCell((short) 13).getStringCellValue()
							.equals(""))
					|| (linha.getCell((short) 13).getStringCellValue()
							.equals(" "))) {
				infoDisciplina = "";
			} else {
				conteudo = linha.getCell((short) 13);
				infoDisciplina = conteudo.getStringCellValue();
			}

			if ((linha.getCell((short) 11) == null)
					|| (linha.getCell((short) 11).getStringCellValue()
							.equals(""))
					|| (linha.getCell((short) 11).getStringCellValue()
							.equals(" "))) {
				codigo = "";
			} else {
				conteudo = linha.getCell((short) 11);
				codigo = conteudo.getStringCellValue();
			}

			if (linha.getCell((short) 15) == null) {
				
			} else {
				conteudo = linha.getCell((short) 15);
				endInternet = conteudo.getStringCellValue();
			}

			Vector nomeProfessor = new Vector(3);
			nomeProfessor.add(0, professor1);
			nomeProfessor.add(1, professor2);
			nomeProfessor.add(2, professor3);
			Alocacao alocacao = new Alocacao(nomeDisciplina, codigo,
					endInternet, new BigDecimal(numDeCredito),
					disciplinaConjunto, nomeProfessor, infoDisciplina);
			this.inserirAlocacao(alocacao);
		}
	}

	/**
	 * Retorna o Vector.
	 */
	public Vector getVectorAlocacao() {
		return this.vectorAlocacao;
	}

	public Iterator getIterator() {
		return this.vectorAlocacao.iterator();
	}

	/**
	 * Insere uma disciplina no list
	 * 
	 * @param a
	 *            Dados da disciplina a ser inserida na list.
	 */
	public synchronized void inserirAlocacao(Alocacao a) {
		if (a != null) {
			this.vectorAlocacao.addElement(a);
		}
	}

	/**
	 * Remove uma disciplina no vector
	 * 
	 * @param d
	 *            Dados da alocação a ser removida do vector.
	 */

	public synchronized void removerAlocacao(Alocacao alocacao) {
		if (alocacao!=null) {
			this.vectorAlocacao.remove(alocacao);
		}
	}

	/**
	 * Procura uma alocação.
	 * 
	 * @param n
	 *            O nome da disciplina a ser procurada.
	 * 
	 * @return Retorna um objeto do tipo RepAlocacao que contém no atributo
	 *         vectorAlocacao as disciplinas cadastradas com o mesmo nome.
	 */
	public synchronized Vector procurarAlocacao(String n) {
		Vector retorno = new Vector();
		if (n != null) {
			Iterator iteRepAlocacao = this.getIterator();
			while (iteRepAlocacao.hasNext()) {
				Alocacao alocacao = null;
				Object next = iteRepAlocacao.next();
				if (next instanceof Alocacao) {
					alocacao = (Alocacao)next;				
					if (n.equalsIgnoreCase(alocacao.getNomeDisciplina())) {
						retorno.add(alocacao);
					}
				}
			}
		}
		return retorno;
	}

	/**
	 * Verifica se uma disciplina existe no vector.
	 * 
	 * @param a
	 *            Dados da disciplina.
	 * 
	 * @return boolean True se existir ou false se não existir.
	 */
	public synchronized boolean existeAlocacao(Alocacao a) {
		boolean existe = false;
		if (a != null) {
			if (this.procurarIndice(a) != -1) {
				existe = true;
			}
		}
		return existe;
	}

	/**
	 * Procura o índice de uma disciplina.
	 * 
	 * @param a
	 *            Os dados da disciplina a ser procurada.
	 * 
	 * @return Retorna o índice da vector onde a disciplina se encontra.
	 */
	public synchronized int procurarIndice(Alocacao a) {
		int cont = -1;
		if (a != null) {
			boolean achou = false;
			Iterator iteRepAlocacao = this.getIterator();
			Alocacao alocacao = null;
			while ((iteRepAlocacao.hasNext()) && (!achou)) {
				alocacao = (Alocacao) iteRepAlocacao.next();
				if (alocacao instanceof Alocacao) {
					if ((a.getCodigo().equalsIgnoreCase(alocacao.getCodigo()))
							&& (a.getdisciplinaConjunto()
									.equalsIgnoreCase(alocacao
											.getdisciplinaConjunto()))
							&& (a.getEndInternet().equalsIgnoreCase(alocacao
									.getEndInternet()))
							&& (a.getNomeDisciplina().equalsIgnoreCase(alocacao
									.getNomeDisciplina()))
							&& (a.getNomeProfessor1().equalsIgnoreCase(alocacao
									.getNomeProfessor1()))
							&& (a.getNomeProfessor2().equalsIgnoreCase(alocacao
									.getNomeProfessor2()))
							&& (a.getNomeProfessor3().equalsIgnoreCase(alocacao
									.getNomeProfessor3()))
							&& (a.getNumDeCredito() == (alocacao
									.getNumDeCredito()))) {
						achou = true;
						cont = this.vectorAlocacao.indexOf(iteRepAlocacao
								.next());
					}
				}
			}
		}
		return cont;
	}

	/**
	 * Armazena num objeto do tipo RepAlocacao as disciplinas lecionadas por um
	 * mesmo docente.
	 * 
	 * @param n
	 *            Nome do docente.
	 * @param i
	 *            Tamanho do vector das disciplinas.
	 * 
	 * return RepAlocacao Conjunto das disciplinas lecionadas pelo mesmo
	 * docente.
	 */
	public synchronized Vector vectorConjuntoDisciplina(String nomeDocente) {
		Vector retorno = new Vector();
		Iterator iterator = this.vectorAlocacao.iterator();
		Alocacao alocacao = null;
		if (nomeDocente != null) {
			while (iterator.hasNext()) {
				Object next = iterator.next();
				if (next instanceof Alocacao) {
					alocacao = (Alocacao)next;
					if (nomeDocente.equalsIgnoreCase(alocacao.getNomeProfessor1())) {
						retorno.add(alocacao);
					} else if (nomeDocente.equalsIgnoreCase(alocacao.getNomeProfessor2())) {
						retorno.add(alocacao);
					} else if (nomeDocente.equalsIgnoreCase(alocacao.getNomeProfessor3())) {
						retorno.add(alocacao);
					}
				}
			}
		}
		return retorno;
	}
}