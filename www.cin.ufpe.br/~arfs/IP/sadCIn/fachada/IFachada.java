/*
 * Created on 13/03/2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package fachada;

import java.util.Vector;

import relatorio.RepRelatorio;
import alocacao.Alocacao;
import docente.Docente;
import exceptions.JaExisteException;
import exceptions.NaoExisteException;
import exceptions.ObjetoNuloException;
import java.rmi.Remote;
import java.rmi.RemoteException;;

/**
 * @author luizdb
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public interface IFachada extends Remote {
	/**
	 * Verifica se o docente está preenchido
	 * e faz a chamada do método da classe de negócios.
	 */
	public abstract void inserirDocente(Docente d) throws ObjetoNuloException,
			JaExisteException, RemoteException;

	/**
	 * Verifica se a String está preenchida
	 * e faz a chamada do método da classe de negócios.
	 */
	public abstract void removerDocente(String n) throws ObjetoNuloException,
			NaoExisteException, RemoteException;

	/**
	 * Verifica se a String está preenchida
	 * e faz a chamada do método da classe de negócios.
	 * 
	 * @return
	 * Retorna um objeto do tipo Docente.
	 */
	public abstract Docente procurarDocente(String n)
			throws ObjetoNuloException, NaoExisteException, RemoteException;

	/**
	 * Verifica se o docente está preenchido
	 * e faz a chamada do método da classe de negócios.
	 */
	public abstract void alterarDocente(Docente d) throws ObjetoNuloException, RemoteException;

	/**
	 * Verifica se a disciplina está preenchida
	 * e faz a chamada do método da classe de negócios.
	 */
	public abstract void inserirAlocacao(Alocacao a)
			throws ObjetoNuloException, JaExisteException, RemoteException;

	/**
	 * Verifica se o inteiro não é negativo
	 * e faz a chamada do método da classe de negócios.
	 * 
	 * @param i
	 * Posição no array que a disciplina se encontra.
	 */
	public abstract void removerAlocacao(Alocacao alocacao) throws RemoteException;

	/**
	 * Verifica se a String está preenchida
	 * e faz a chamada do método da classe de negócios.
	 */
	public abstract Vector procurarAlocacao(String n)
			throws ObjetoNuloException, NaoExisteException, RemoteException;

	/**
	 * Faz a chamada do método da classe de dados.
	 */
	public abstract RepRelatorio gerarRelatorio() throws RemoteException;
}