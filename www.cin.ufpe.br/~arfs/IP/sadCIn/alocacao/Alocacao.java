/*
 *Primeira parte do Projeto de IP
 *Classe: Alocacao
 */

package alocacao;

import java.util.Vector;
import java.io.Serializable;
import java.math.BigDecimal;

/**
 * @author Aluisio Rodrigo Fonseca de Santana - arfs
 * @author Henrique Seabra Diniz - hsd
 */

public class Alocacao implements Serializable{
	private String nomeDisciplina;
	private String codigo;
	private String endInternet;
	private String disciplinaConjunto;
	private Vector nomeProfessor;
	private int numeroProfessores;
	private int indice;
	private BigDecimal numDeCredito;
	private String infoDisciplina;
	
	/**
	 * Construtor da classe Alocacao.
	 * 
	 * @param nomeDisciplina
	 * @param codigo
	 * @param endInternet
	 * @param numDeCredito
	 * @param disciplinaConjunto
	 * @param nomeProfessor
	 * @param infoDiscplina
	 */
	public Alocacao(String nomeDisciplina, String codigo, String endInternet,
			BigDecimal numDeCredito, String disciplinaConjunto, Vector nomeProfessor, String infoDisciplina) {
		this.nomeDisciplina = nomeDisciplina;
		this.codigo = codigo;
		this.endInternet = endInternet;
		this.numDeCredito = numDeCredito;
		this.disciplinaConjunto = disciplinaConjunto;
		this.nomeProfessor = nomeProfessor;
		this.setNumProfessor();
		this.infoDisciplina = infoDisciplina;
	}

	/**
	 * @return 
	 * Retorna o c�digo.
	 */
	public String getCodigo() {
		return this.codigo;
	}

	/**
	 * @return 
	 * Retorna o endere�o na internet.
	 */
	public String getEndInternet() {
		return this.endInternet;
	}

	/**
	 * @return 
	 * Retorna o o nome da disciplina em conjunto.
	 */
	public String getdisciplinaConjunto() {
		return this.disciplinaConjunto;
	}
	
	/**
	 * @return 
	 * Retorna o nome da disciplina.
	 */
	public String getNomeDisciplina() {
		return this.nomeDisciplina;
	}
	
	/**
	 * @return 
	 * Retorna o cr�dito.
	 */
	public BigDecimal getNumDeCredito() {
		return this.numDeCredito;
	}
	
	/**
	 * @return 
	 * Retorna o nome do 1� professor da disciplina.
	 */
	public String getNomeProfessor1() {
		String nome = "";
		if (this.nomeProfessor.elementAt(0) instanceof String) {
			nome = (String)this.nomeProfessor.elementAt(0);
		}
		return nome;
	}
	
	/**
	 * @return 
	 * Retorna o nome do 2� professor da disciplina.
	 */
	public String getNomeProfessor2() {
		String nome = "";
		if (this.nomeProfessor.elementAt(1) instanceof String) {
			nome = (String)this.nomeProfessor.elementAt(1);
		}
		return nome;
	}
	
	/**
	 * @return 
	 * Retorna o nome do 3� professor da disciplina.
	 */
	public String getNomeProfessor3() {
		String nome = "";
		if (this.nomeProfessor.elementAt(2) instanceof String) {
			nome = (String)this.nomeProfessor.elementAt(2);
		}
		return nome;
	}
	
	/**
	 * @return 
	 * Retorna o n�mero de professores que lecionam a disciplina.
	 */
	public int getNumeroProfessores() {
		return numeroProfessores;
	}
	
	public String getInfoDisciplina() {
		return this.infoDisciplina;
	}

	/**
	 * Insere o n�mero de professores em numeroProfessores.
	 */
	public void setNumProfessor() {
		int numeroProfessores = 0;
		if ((this.getNomeProfessor1().equals("")) && (this.getNomeProfessor1().equals(" "))) {
			this.numeroProfessores = 0;
		}else if ((this.getNomeProfessor2().equals("")) || (this.getNomeProfessor2().equals(" "))) {
			this.numeroProfessores = 1;
		}else if ((this.getNomeProfessor3().equals("")) || (this.getNomeProfessor3().equals(" "))) {
			this.numeroProfessores = 2;
		}else {
			this.numeroProfessores = 3;
		}
	}
	
	public void setIndice(int i) {
		this.indice = i;
	}
	
	/**
	 * Monta um relat�rio com todos os atributos da disciplina.
	 * A fun��o String.valueOf() foi utilizada para transformar a vari�vel
	 * num getNumDeCredito (double) em String.
	 */
	public String imprimirAlocacao() {
		return ("N�mero: " + String.valueOf(this.indice) + '\n' + 
				"Nome da disciplina: " + this.getNomeDisciplina() + '\n' + 
				"C�digo: " + this.getCodigo() + '\n' + 
				"Disciplina em conjunto: " + this.getdisciplinaConjunto()+ '\n' + 
				"Cr�ditos: " + String.valueOf(this.getNumDeCredito()) + '\n' +
				"Curso: " + this.getInfoDisciplina() + '\n' +
				"Professor 1: " + this.getNomeProfessor1() + '\n' + 
				"Professor 2: " + this.getNomeProfessor2() + '\n' +  
				"Professor 3: " + this.getNomeProfessor3() + '\n' + 
				"Endere�o na internet: " + this.getEndInternet()) + '\n';
	}
}