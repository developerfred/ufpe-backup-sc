/*
 *Primeira parte do Projeto de IP
 *Classe: RepDocente
 */

package relatorio;
import alocacao.*;
import docente.*;
import java.util.*;
import java.io.Serializable;
import java.math.BigDecimal;
import util.CompararCredito;
import util.CompararNome;

/**
 * @author Aluísio Rodrigo Fonseca de Santana - arfs
 * @author Henrique Seabra Diniz - hsd
 */
public class RepRelatorio implements Serializable{
	private Vector vectorRelatorio;
	
	/**
	 * Construtor da classe RepRelatório.
	 */
	public RepRelatorio() {
		this.vectorRelatorio = new Vector();
	}
	
	public Vector getVectorRelatorio(){
		return vectorRelatorio;
	}
	
	public Iterator getIterator() {
		return this.vectorRelatorio.iterator();
	}

	/**
	 * Insere um relatório no Vector.
	 *
	 * @param r
	 * Dados do relatório a ser inserido no array.
	 */
	public void inserirRelatorio(Relatorio r) {
		if (r != null) {
			this.vectorRelatorio.add(r);
		}
	}
	
	/**
	 * Recebe o array dos docente, o array das disciplinas e gera o relatório por docente.
	 * @param negAlocacao
	 * @param negDocente
	 * @return
	 * Um objeto do tipo RepRelatorio com o relatório de todos os docentes.
	 */
	public RepRelatorio gerarRelatorio(NegAlocacao negAlocacao, NegDocente negDocente) {
		RepRelatorio repRelatorio = new RepRelatorio(); // Objeto para guardar os relatórios
		if ((negAlocacao != null) && (negDocente != null)) { 
			Docente docente = null; // Objeto para guardar os dados do docente.
			Relatorio relatorio = new Relatorio(docente, new BigDecimal(0), ""); // Objeto para guardar os dados do relatório.
			Iterator iteRepDocente = negDocente.getIteRepDocente();
			while (iteRepDocente.hasNext()) {
				docente = ((Docente) iteRepDocente.next()); // Guarda os dados do docente armazenado naquela posição do vector.
				String nome = docente.getNome(); // Guarda o nome do docente.
				Vector vectorDisc = null; // Objeto para guardar as disciplinas que este docente leciona.
				vectorDisc = negAlocacao.vectorConjuntoDisciplina(nome); // Chamada do método que vai retornar as disciplinas lecionadas por este docente.
				BigDecimal creditos = new BigDecimal(0);
				String disciplinas = "";
				if (vectorDisc != null || vectorDisc.size()!=0) { // Verifica se o vector é nulo.
					Iterator iteVectorDisc = vectorDisc.iterator();
					Alocacao alocacao = null;
					while (iteVectorDisc.hasNext()) {// Repetirá até chegar na última posição do vector.
						alocacao = (Alocacao) iteVectorDisc.next();
						disciplinas = disciplinas.concat(alocacao.getNomeDisciplina()) + ('\n') + 
						("Curso: ").concat(alocacao.getInfoDisciplina()) + ('\n') +
						("Professores: ") + ('\n') + 
						(alocacao.getNomeProfessor1()) + ('\n') + 
						(alocacao.getNomeProfessor2()) + ('\n') + 
						(alocacao.getNomeProfessor3()) + ('\n');
						// Guarda a concatenação dos nomes das disciplinas lecionadas por este docente.
						creditos = creditos.add(repRelatorio.calcularCredito(alocacao)); // Chamada do método que vai calcular o crédito que este docente deve receber por disciplina.
					}
				}
				relatorio = new Relatorio(docente, creditos, disciplinas); // Atribuindo valores para os atributos do relatório.	
				repRelatorio.inserirRelatorio(relatorio); // inserindo o relatório no vector.
			}
		}
		return repRelatorio;
	}
	
	/**
	 * Método para calcular os créditos que um docente tem direito por disciplina.
	 *  
	 * @param a
	 * Disciplina
	 * @return
	 * O valor do crédito.
	 */
	public BigDecimal calcularCredito(Alocacao a) {
		BigDecimal creditos = new BigDecimal(0);
		if (a != null) {
			boolean disciplinaConjunto = false;
			if (!a.getdisciplinaConjunto().equals("")) {
				disciplinaConjunto = true;
			}
				
		if ((a.getNumeroProfessores() == 1) && (disciplinaConjunto == false)) { // 1 professor sem discipina em conjunto = crédito integral.
				creditos = a.getNumDeCredito();
			}else if ((a.getNumeroProfessores() == 1) && (disciplinaConjunto == true)) { // 1 professor com discipina em conjunto = 1/2 do crédito.
				creditos = (a.getNumDeCredito().divide(BigDecimal.valueOf(2),2,BigDecimal.ROUND_DOWN));
			}else if((a.getNumeroProfessores() == 2) && (disciplinaConjunto == false)) { // 2 professores sem discipina em conjunto = 1/2 do crédito.
				creditos = (a.getNumDeCredito().divide(BigDecimal.valueOf(2),2,BigDecimal.ROUND_DOWN));
			}else if ((a.getNumeroProfessores() == 2) && (disciplinaConjunto == true)) { // 2 professores com discipina em conjunto = 1/4 do crédito.
				creditos = (a.getNumDeCredito().divide(BigDecimal.valueOf(4),2,BigDecimal.ROUND_DOWN));
			}else if((a.getNumeroProfessores() == 3) && (disciplinaConjunto == false)) { // 3 professores sem discipina em conjunto = 1/3 do crédito.
				creditos = (a.getNumDeCredito().divide(BigDecimal.valueOf(3),2,BigDecimal.ROUND_DOWN));
			}else if ((a.getNumeroProfessores() == 3) && (disciplinaConjunto == true)) { // 3 professores com discipina em conjunto = 1/6 do crédito.
				creditos = (a.getNumDeCredito().divide(BigDecimal.valueOf(6),2,BigDecimal.ROUND_DOWN));
			}
		}
		return creditos;
	}
	
	public void ordenarPorNome() {
		Comparator nome = new CompararNome();
		Collections.sort(this.vectorRelatorio, nome);
	}
	
	public void ordenarPorCredito() {
		Comparator credito = new CompararCredito();
		Collections.sort(this.vectorRelatorio, credito);
	}
}