/*
 *Primeira parte do Projeto de IP
 *Classe: RepDocente
 */

package docente;

import java.util.*;

import util.ExcelCell;
import util.ExcelRow;
import util.ExcelSheet;
import util.ExcelWorkbook;

/**
 * @author Aluísio Rodrigo Fonseca de Santana - arfs
 * @author Henrique Seabra Diniz - hsd
 */
public class RepDocente implements IDocente {
	private Vector vectorDocentes;
	
	/**
	 * Construtor da classe repDocentes.
	 */
	public RepDocente() throws Exception{
		this.vectorDocentes = new Vector();
		init();
	}
	
	private synchronized void init() throws Exception{
		ExcelWorkbook arqXlsDocente = new ExcelWorkbook("H:\\IP\\CorpoDocente2003-2.xls");
		ExcelSheet planilhaDocente = arqXlsDocente.getSheet("CorpoDocente2003-2");
		ExcelCell conteudo;
		String codSiape = "";
		String nome = "";
		String cargo = "";
		String funcao = "";
		String regime = "";
		String endInternet = "";
		for (int cont = 1; cont < 48; cont = cont + 1) {
			ExcelRow linha = planilhaDocente.getRow(cont);
			if ((linha.getCell((short)2) == null) || (linha.getCell((short)2).getStringCellValue().equals("")) || (linha.getCell((short)2).getStringCellValue().equals(" "))) {
				codSiape = "";
			}else {
				conteudo = linha.getCell((short)2);
				codSiape = conteudo.getStringCellValue();
			}
			
			if (linha.getCell((short)0) == null) {
				continue;
			}else {
				conteudo = linha.getCell((short)0);
				nome = conteudo.getStringCellValue();
			}
			
			if ((linha.getCell((short)3) == null) || (linha.getCell((short)3).getStringCellValue().equals("")) || (linha.getCell((short)3).getStringCellValue().equals(" "))) {
				cargo = "";
			}else {
				conteudo = linha.getCell((short)3);
				cargo = conteudo.getStringCellValue();
			}
			
			if ((linha.getCell((short)4) == null) || (linha.getCell((short)4).getStringCellValue().equals("")) || (linha.getCell((short)4).getStringCellValue().equals(" "))) {
				funcao = "";
			}else {
				conteudo = linha.getCell((short)4);
				funcao = conteudo.getStringCellValue();
			}
			
			if (linha.getCell((short)5) == null) {
				continue;
			}else {
				conteudo = linha.getCell((short)5);
				regime = conteudo.getStringCellValue();
			}
			
			if (linha.getCell((short)6) == null) {
				continue;
			}else {
				conteudo = linha.getCell((short)6);
				endInternet = conteudo.getStringCellValue();
			}
			
			Docente docente = new Docente(codSiape, nome, cargo, funcao, regime, endInternet);
			this.inserirDocente(docente);
		}
	}
	
	/**
	 * @return
	 * Retorna o atributo vectorDocentes.
	 */
	public Vector getVectorDocentes() {
		return this.vectorDocentes; 
	}
	
	public Iterator getIterator() {
		return this.vectorDocentes.iterator();
	}
	
	/**
	 * Insere um docente no array, verificando se há espaço.
	 *
	 * @param d
	 * Dados do docente a ser inserido no array.
	 */
	public synchronized void inserirDocente(Docente d) {
		this.vectorDocentes.addElement(d);
	}
	
	/**
	 * Remove um docente do array e coloca o último
	 * objeto do array na posição do que foi excluído.
	 *
	 * @param n
	 * Nome do docente a ser removido do array.
	 */
	public synchronized void removerDocente(String n) {
		if (this.procurarIndDocente(n) != -1) {
			this.vectorDocentes.removeElementAt(this.procurarIndDocente(n));
		}
	}
	
	/**
	 * Procura um docente no array.
	 * 
	 * @param n
	 * Nome do docente.
	 * 
	 * @return
	 * Objeto do tipo Docente.
	 */
	public synchronized Docente procurarDocente(String n) {
		Docente docente = null;
		int indDocente = procurarIndDocente(n);
		if (indDocente != -1) {
			docente = ((Docente) this.vectorDocentes.elementAt(indDocente));
		}
		return docente;	
	}
	
	/**
	 * Verifica se um docente existe no array
	 * 
	 * @param n
	 * Nome do docente.
	 * 
	 * @return
	 * True se existir ou false se não existir.
	 */
	public synchronized boolean existeDocente(String n) {
		boolean existe = false;
		if (this.procurarIndDocente(n) != -1) {
			existe = true;
		}
		return existe;
		}
		
		/**
		 * Procura a posição do array onde o docente se encontra.
		 *
		 * @param n
		 * O nome do docente a ser procurado
		 *
		 * @return
		 * Retorna o índice do array onde o docente se encontra,
		 * ou proxima caso não encontre ou seja null o argumento.
		 */
		public synchronized int procurarIndDocente(String n) {
			int indice = -1;
			Iterator iteRepDocente = this.getIterator();
			Docente docente = null;
			boolean achou = false;
			while ((iteRepDocente.hasNext()) && (!achou)) {
				docente = (Docente) iteRepDocente.next();
				if (docente instanceof Docente) {
					if (n.equalsIgnoreCase(docente.getNome()) ) {
						achou = true;
						indice = this.vectorDocentes.indexOf(docente);
					}
				}
			}
			return indice;
		}
		
		/**
		 * Modifica um docente do array, caso exista.
		 *
		 * @param d
		 * Novos dados do docente a serem atualizados.
		 */
		public synchronized void alterarDocente(Docente d) {
			int indDocente = this.procurarIndDocente(d.getNome());
			if (indDocente != -1) {
				this.vectorDocentes.setElementAt(d, indDocente);
			}
		}
	}