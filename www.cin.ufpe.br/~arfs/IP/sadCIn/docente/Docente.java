/*
 *Primeira parte do Projeto de IP
 *Classe: Docente
 */

package docente;

import java.io.Serializable;

/**
 * @author Aluísio Rodrigo Fonseca de Santana - arfs
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
	 * Retorna o código SIAPE.
	 */
	public String getCodSiape() {
		return this.codSiape;
	}
	
	/**
	 * @return 
	 * Retorna o endereço na internet.
	 */
	public String getEndInternet() {
		return this.endInternet;
	}
	
	/**
	 * @return
	 * Retorna a função.
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
	 * Monta um relatório com todos os atributos do docente.
	 */
	public String imprimirDocente() {
		return ("Nome: " + this.getNome() + '\n' + "Código SIAPE: " + this.getCodSiape() + '\n' + 
				"Função: " + this.getFuncao() + '\n' + "Cargo: " + this.getCargo() + '\n' + 
				"Regime: " + this.getRegime() + '\n' + "Endereço na internet: " + this.getEndInternet() + '\n');
	}
}