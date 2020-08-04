/*
 *Primeira parte do Projeto de IP
 *Classe: Docente
 */

package docente;

import java.io.Serializable;

/**
 * @author Alu�sio Rodrigo Fonseca de Santana - arfs
 * @author Henrique Seabra Diniz - hsd
 */
public class Docente implements Serializable{
	private String codSiape;
	private String nome;
	private String cargo;
	private String funcao;
	private String regime;
	private String endInternet;
	
	/**
	 * Construtor da classe Docentes.
	 * @param codSiape
	 * @param nome
	 * @param cargo
	 * @param funcao
	 * @param regime
	 * @param endInternet
	 */
	public Docente(String codSiape, String nome, String cargo, String funcao,
			String regime, String endInternet) {
		this.codSiape = codSiape;
		this.nome = nome;
		this.cargo = cargo;
		this.funcao = funcao;
		this.regime = regime;
		this.endInternet = endInternet;
	}
	
	/**
	 * @return 
	 * Retorna o cargo.
	 */
	public String getCargo() {
		return this.cargo;
	}
	
	/**
	 * @return 
	 * Retorna o c�digo SIAPE.
	 */
	public String getCodSiape() {
		return this.codSiape;
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
	 * Retorna a fun��o.
	 */
	public String getFuncao() {
		return funcao;
	}
	
	/**
	 * @return 
	 * Retorna o nome.
	 */
	public String getNome() {
		return this.nome;
	}
	
	/**
	 * @return 
	 * Retorna o regime.
	 */
	public String getRegime() {
		return this.regime;
	}
	
	/**
	 * Monta um relat�rio com todos os atributos do docente.
	 */
	public String imprimirDocente() {
		return ("Nome: " + this.getNome() + '\n' + "C�digo SIAPE: " + this.getCodSiape() + '\n' + 
				"Fun��o: " + this.getFuncao() + '\n' + "Cargo: " + this.getCargo() + '\n' + 
				"Regime: " + this.getRegime() + '\n' + "Endere�o na internet: " + this.getEndInternet() + '\n');
	}
}