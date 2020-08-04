/*
 *Primeira parte do Projeto de IP
 *Classe: IAlocacao
 */

package alocacao;
import java.util.*;

/**
 * @author Aluisio Rodrigo Fonseca de Santana - arfs
 * @author Henrique Seabra Diniz - hsd
 */

public interface IAlocacao {
	public void inserirAlocacao(Alocacao n);
	public void removerAlocacao(Alocacao alocacao);
	public Vector procurarAlocacao(String n);
	public boolean existeAlocacao(Alocacao a);
	public Vector vectorConjuntoDisciplina(String nomeDocente);
	public Vector getVectorAlocacao();
}
