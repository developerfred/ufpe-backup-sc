/*
 *Primeira parte do Projeto de IP
 *Classe: Docente
 */

package relatorio;
import docente.Docente;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * @author Alu�sio Rodrigo Fonseca de Santana - arfs
 * @author Henrique Seabra Diniz - hsd
 */
public class Relatorio implements Serializable{
	private Docente docente;
	private BigDecimal creditos;
	private String nomeDisciplinas;
	
	/**
	 * Construtor da classe Relatorio
	 * @param docente
	 * @param creditos
	 * @param nomeDisciplinas
	 */
	public Relatorio(Docente docente, BigDecimal creditos, String nomeDisciplinas) {
		this.docente = docente;
		this.creditos = creditos;
		this.nomeDisciplinas = nomeDisciplinas;
	}
	
	
	/**
	 * @return 
	 * Retona o atributo creditos
	 */
	public BigDecimal getCreditos() {
		return this.creditos;
	}
	/**
	 * @return
	 * Retona o atributo docente.
	 */
	public Docente getDocente() {
		return this.docente;
	}
	/**
	 * @return 
	 * Retona o atributo nomeDisciplinas.
	 */
	public String getNomeDisciplinas() {
		return this.nomeDisciplinas;
	}
	
	/**
	 * Monta um relat�rio com todos os atributos do relat�rio.
	 */
	public String imprimirRelatorio() {
		return ("Nome: " + this.docente.getNome() + '\n' + 
				"Cr�ditos: " + String.valueOf(creditos) + '\n') +
				"C�digo SIAPE: " + this.docente.getCodSiape() + '\n' + 
				"Fun��o: " + this.docente.getFuncao() + '\n' + 
				"Cargo: " + this.docente.getCargo() + '\n' + 
				"Regime: " + this.docente.getRegime() + '\n' + 
				"Endere�o na internet: " + this.docente.getEndInternet() + '\n' + 
				"Disciplinas: " + ('\n') + this.getNomeDisciplinas(); 
	}

}