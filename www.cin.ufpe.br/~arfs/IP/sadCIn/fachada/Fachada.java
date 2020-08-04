/*
 *Primeira parte do Projeto de IP
 *Classe: RepDocente
 */

package fachada;
import alocacao.*;
import docente.*;
import exceptions.*;
import relatorio.*;
import sun.rmi.registry.RegistryImpl;

import java.util.*;
import java.rmi.*;
import java.rmi.server.UnicastRemoteObject;

/**
 * @author Aluísio Rodrigo Fonseca de Santana - arfs
 * @author Henrique Seabra Diniz - hsd
 */

public class Fachada  extends UnicastRemoteObject implements IFachada{
	private NegDocente fachadaDocente;
	private NegAlocacao fachadaAlocacao;
	private RepRelatorio fachadaRelatorio;
	
	/**
	 * Construtor da classe Fachada.
	 */
	public Fachada() throws Exception{
		this.fachadaDocente = new NegDocente();
		this.fachadaAlocacao = new NegAlocacao();
		this.fachadaRelatorio = new RepRelatorio();
	}
	
	/**
	 * @return
	 * Retorna o atributo fachadaDocente.
	 */
	public NegDocente getNegDocente() {
		return this.fachadaDocente;
	}
	
	/**
	 * @return
	 * Retorna o atributo fachadaAlocacao.
	 */
	public NegAlocacao getNegAlocacao() {
		return this.fachadaAlocacao;
	}
	
	/**
	 * Verifica se o docente está preenchido
	 * e faz a chamada do método da classe de negócios.
	 */
	public void inserirDocente(Docente d) throws ObjetoNuloException, JaExisteException {
		System.out.println("Executando inserirDocente");
		this.fachadaDocente.inserirDocente(d);
	}
	
	/**
	 * Verifica se a String está preenchida
	 * e faz a chamada do método da classe de negócios.
	 */
	public void removerDocente(String n) throws ObjetoNuloException, NaoExisteException {
		this.fachadaDocente.removerDocente(n);
	}
	
	/**
	 * Verifica se a String está preenchida
	 * e faz a chamada do método da classe de negócios.
	 * 
	 * @return
	 * Retorna um objeto do tipo Docente.
	 */
	public Docente procurarDocente(String n) throws ObjetoNuloException, NaoExisteException{
		System.out.println("Executando procurarDocente");
		Docente docente = this.fachadaDocente.procurarDocente(n);
		return docente;
	}
	
	/**
	 * Verifica se o docente está preenchido
	 * e faz a chamada do método da classe de negócios.
	 */
	public void alterarDocente(Docente d) throws ObjetoNuloException{
		this.fachadaDocente.alterarDocente(d);
	}
	
	/**
	 * Verifica se a disciplina está preenchida
	 * e faz a chamada do método da classe de negócios.
	 */
	public void inserirAlocacao(Alocacao a) throws ObjetoNuloException, JaExisteException {
		this.fachadaAlocacao.inserirAlocacao(a);
	}
	
	/**
	 * Verifica se o inteiro não é negativo
	 * e faz a chamada do método da classe de negócios.
	 * 
	 * @param i
	 * Posição no array que a disciplina se encontra.
	 */

	
	public void removerAlocacao(Alocacao alocacao){
		this.fachadaAlocacao.removerAlocacao(alocacao);
	}
	
	
	/**
	 * Verifica se a String está preenchida
	 * e faz a chamada do método da classe de negócios.
	 */
	public Vector procurarAlocacao(String n) throws ObjetoNuloException, NaoExisteException {
		Vector retorno = this.fachadaAlocacao.procurarAlocacao(n);
		return retorno;
	}
		
	/**
	 * Faz a chamada do método da classe de dados.
	 */
	public RepRelatorio gerarRelatorio() {
		return this.fachadaRelatorio.gerarRelatorio(this.fachadaAlocacao, this.fachadaDocente);
	}
	
	public static void main(String [] kk){
		/*if (System.getSecurityManager() == null) {
            System.setSecurityManager(new RMISecurityManager());
        }*/
        String name = "//localhost:5020/Fachada";
        try {
        	new RegistryImpl(5020);
        	Fachada fachada = new Fachada();
            Naming.rebind(name, fachada);
            System.out.println("Fachada bound");
        } catch (Exception e) {
            System.err.println("Fachada exception: " + 
			       e.getMessage());
            e.printStackTrace();
        }

	}
	
}

