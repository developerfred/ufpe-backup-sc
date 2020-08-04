/*
 * Created on 13/03/2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package gui;

import javax.swing.JFrame;

import java.awt.GridLayout;
import java.util.Iterator;
import java.util.Vector;

import javax.swing.JMenuBar;
import javax.swing.JMenu;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JTextArea;

import relatorio.Relatorio;
import relatorio.RepRelatorio;
import alocacao.Alocacao;

import util.Console;

import docente.Docente;
import exceptions.NaoExisteException;
import exceptions.ObjetoNuloException;

import fachada.IFachada;

import javax.swing.JScrollBar;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import java.rmi.*;

/**
 * @author
 * 
 * TODO To change the template for this generated type comment go to Window -
 * Preferences - Java - Code Style - Code Templates
 */
public class GuiCliente extends JFrame {

	private IFachada interfaceUsuario;

	private javax.swing.JPanel jContentPane = null;

	private JMenuBar jJMenuBar = null;

	private JMenu jMenu = null;

	private JMenu jMenu1 = null;

	private JMenuItem jMenuItem = null;

	private JMenuItem jMenuItem1 = null;

	private JMenuItem jMenuItem2 = null;

	private JTextArea jTextArea = null;

	private JMenuItem jMenuItem3 = null;

	private JMenuItem jMenuItem4 = null;

	private JMenuItem jMenuItem5 = null;

	private JMenuItem jMenuItem6 = null;

	private JMenuItem jMenuItem7 = null;

	private JMenuItem jMenuItem8 = null;

	private JMenuItem jMenuItem9 = null;

	private JScrollBar jScrollBar = null;

	private JScrollPane jScrollPane = null;

	/**
	 * This method initializes jJMenuBar
	 * 
	 * @return javax.swing.JMenuBar
	 */
	private JMenuBar getJJMenuBar() {
		if (jJMenuBar == null) {
			jJMenuBar = new JMenuBar();
			jJMenuBar.add(getJMenu());
			jJMenuBar.add(getJMenu1());
		}
		return jJMenuBar;
	}

	/**
	 * This method initializes jMenu
	 * 
	 * @return javax.swing.JMenu
	 */
	private JMenu getJMenu() {
		if (jMenu == null) {
			jMenu = new JMenu();
			jMenu.setText("Arquivo");
			jMenu.add(getJMenuItem9());
		}
		return jMenu;
	}

	/**
	 * This method initializes jMenu1
	 * 
	 * @return javax.swing.JMenu
	 */
	private JMenu getJMenu1() {
		if (jMenu1 == null) {
			jMenu1 = new JMenu();
			jMenu1.setText("Ações");
			jMenu1.add(getJMenuItem());
			jMenu1.add(getJMenuItem1());
			jMenu1.add(getJMenuItem2());
			jMenu1.add(getJMenuItem3());
			jMenu1.add(getJMenuItem4());
			jMenu1.add(getJMenuItem5());
			jMenu1.add(getJMenuItem6());
			jMenu1.add(getJMenuItem7());
			jMenu1.add(getJMenuItem8());
		}
		return jMenu1;
	}

	/**
	 * This method initializes jMenuItem
	 * 
	 * @return javax.swing.JMenuItem
	 */
	private JMenuItem getJMenuItem() {
		if (jMenuItem == null) {
			jMenuItem = new JMenuItem();
			jMenuItem.setText("Inserir Professor");
		}
		return jMenuItem;
	}

	/**
	 * This method initializes jMenuItem1
	 * 
	 * @return javax.swing.JMenuItem
	 */
	private JMenuItem getJMenuItem1() {
		if (jMenuItem1 == null) {
			jMenuItem1 = new JMenuItem();
			jMenuItem1.setText("Remover Professor");
			jMenuItem1.addActionListener(new java.awt.event.ActionListener() {
				public void actionPerformed(java.awt.event.ActionEvent e) {
					removerDocenteAction();
				}
			});
		}
		return jMenuItem1;
	}

	/**
	 * This method initializes jMenuItem2
	 * 
	 * @return javax.swing.JMenuItem
	 */
	private JMenuItem getJMenuItem2() {
		if (jMenuItem2 == null) {
			jMenuItem2 = new JMenuItem();
			jMenuItem2.setText("Procurar Professor");
			jMenuItem2.addActionListener(new java.awt.event.ActionListener() {
				public void actionPerformed(java.awt.event.ActionEvent e) {
					procurarDocenteAction();
				}
			});
		}
		return jMenuItem2;
	}

	/**
	 * This method initializes jScrollBar
	 * 
	 * @return javax.swing.JScrollBar
	 */
	private JScrollBar getJScrollBar() {
		if (jScrollBar == null) {
			jScrollBar = new JScrollBar();
		}
		return jScrollBar;
	}

	/**
	 * This method initializes jTextArea
	 * 
	 * @return javax.swing.JTextArea
	 */
	private JTextArea getJTextArea() {
		if (jTextArea == null) {
			jTextArea = new JTextArea();
			jTextArea.setEditable(false);
		}
		return jTextArea;
	}

	private void procurarDocenteAction() {
		try {
			String nome = JOptionPane.showInputDialog(this,
					"Por favor, informe o nome do professor:");
			Docente docente = this.interfaceUsuario.procurarDocente(nome);
			if (docente != null) {
				JTextArea area = this.getJTextArea();
				area.setText("");
				area.setText(area.getText() + docente.imprimirDocente());
			} else {
				this.alertar("Professor não encontrado para o nome " + nome);
			}
		} catch (NaoExisteException nee) {
			this.alertar(nee.getMessage());
		} catch (Exception e) {
			this.alertar("Erro: " + e.getMessage());
		}
	}

	private void procurarDisciplinaAction() {

		try {
			String nome = JOptionPane.showInputDialog(this,
					"Por favor, informe o nome da disciplina:");
			Vector vAlocacao = this.interfaceUsuario.procurarAlocacao(nome);
			if (vAlocacao != null && vAlocacao.size() != 0) {
				JTextArea area = this.getJTextArea();
				for (int i = 0; i < vAlocacao.size(); i++) {
					Alocacao alocacao = (Alocacao) vAlocacao.get(i);
					area.setText("");
					area.setText(area.getText() + alocacao.imprimirAlocacao());
				}
			} else {
				this.alertar("Disciplina não encontrata para o nome " + nome);
			}
		} catch (NaoExisteException nee) {
			this.alertar(nee.getMessage());
		} catch (Exception e) {
			this.alertar("Erro: " + e.getMessage());
		}

	}

	private void removerDocenteAction() {

		try {
			String nome = JOptionPane.showInputDialog(this,
					"Informe o nome do professor:");
			Docente docente = null;
			try {
				docente = this.interfaceUsuario.procurarDocente(nome);
			} catch (NaoExisteException nee) {
				alertar("Professor " + nome + " nao encontrado!");
			}
			if (docente != null) {
				int resp = JOptionPane.showConfirmDialog(this, docente
						.imprimirDocente()
						+ "\nDeseja excluir? ");

				if (resp == JOptionPane.YES_OPTION) {
					this.interfaceUsuario.removerDocente(docente.getNome());
					this.alertar("Docente excluído.");
				}
			}
		} catch (Exception e) {
			this.alertar("Erro: " + e.getMessage());
		}

	}

	private void removerDisciplinaAction() {
		try {
			String nome = JOptionPane.showInputDialog(this,
					"Por favor, informe o nome da disciplina:");
			Vector alocacaoARemover = this.interfaceUsuario
					.procurarAlocacao(nome);
			Iterator iteRepAlocacao = alocacaoARemover.iterator();
			Alocacao alocacao = null;
			String texto = "";
			while (iteRepAlocacao.hasNext()) {
				alocacao = (Alocacao) iteRepAlocacao.next();
				texto = texto + alocacao.imprimirAlocacao();
				texto = texto + "\n";
			}
			String sIndice = JOptionPane.showInputDialog(this,
					"Digite o número da disciplina a ser removida: \n" + texto);
			if (sIndice != null && sIndice.trim().length() != 0) {
				int indice = Integer.parseInt(sIndice);
				this.interfaceUsuario
						.removerAlocacao((Alocacao) alocacaoARemover
								.get(indice));
			}
		} catch (Exception e) {
			this.alertar(e.getMessage());
		}

	}

	/**
	 * This method initializes jMenuItem3
	 * 
	 * @return javax.swing.JMenuItem
	 */
	private JMenuItem getJMenuItem3() {
		if (jMenuItem3 == null) {
			jMenuItem3 = new JMenuItem();
			jMenuItem3.setText("Atualizar Professor");
		}
		return jMenuItem3;
	}

	/**
	 * This method initializes jMenuItem4
	 * 
	 * @return javax.swing.JMenuItem
	 */
	private JMenuItem getJMenuItem4() {
		if (jMenuItem4 == null) {
			jMenuItem4 = new JMenuItem();
			jMenuItem4.setText("Inserir Disciplina");
		}
		return jMenuItem4;
	}

	/**
	 * This method initializes jMenuItem5
	 * 
	 * @return javax.swing.JMenuItem
	 */
	private JMenuItem getJMenuItem5() {
		if (jMenuItem5 == null) {
			jMenuItem5 = new JMenuItem();
			jMenuItem5.setText("Remover Disciplina");
			jMenuItem5.addActionListener(new java.awt.event.ActionListener() {
				public void actionPerformed(java.awt.event.ActionEvent e) {
					removerDisciplinaAction();
				}
			});
		}
		return jMenuItem5;
	}

	/**
	 * This method initializes jMenuItem6
	 * 
	 * @return javax.swing.JMenuItem
	 */
	private JMenuItem getJMenuItem6() {
		if (jMenuItem6 == null) {
			jMenuItem6 = new JMenuItem();
			jMenuItem6.setText("Procurar Disciplina");
			jMenuItem6.addActionListener(new java.awt.event.ActionListener() {
				public void actionPerformed(java.awt.event.ActionEvent e) {
					procurarDisciplinaAction();
				}
			});
		}
		return jMenuItem6;
	}

	/**
	 * This method initializes jMenuItem7
	 * 
	 * @return javax.swing.JMenuItem
	 */
	private JMenuItem getJMenuItem7() {
		if (jMenuItem7 == null) {
			jMenuItem7 = new JMenuItem();
			jMenuItem7.setText("Relatório por Ordem Alfabética");
			jMenuItem7.addActionListener(new java.awt.event.ActionListener() {
				public void actionPerformed(java.awt.event.ActionEvent e) {
					gerarRelatorioPorOrdemAlfabeticaAction();
				}
			});
		}
		return jMenuItem7;
	}

	/**
	 * This method initializes jMenuItem8
	 * 
	 * @return javax.swing.JMenuItem
	 */
	private JMenuItem getJMenuItem8() {
		if (jMenuItem8 == null) {
			jMenuItem8 = new JMenuItem();
			jMenuItem8.setText("Relatório por Ordem dos Créditos");
			jMenuItem8.addActionListener(new java.awt.event.ActionListener() {
				public void actionPerformed(java.awt.event.ActionEvent e) {
					gerarRelatorioPorOrdemDosCreditosAction();
				}

			});
		}
		return jMenuItem8;
	}

	/**
	 * This method initializes jMenuItem9
	 * 
	 * @return javax.swing.JMenuItem
	 */
	private JMenuItem getJMenuItem9() {
		if (jMenuItem9 == null) {
			jMenuItem9 = new JMenuItem();
			jMenuItem9.setText("Sair");
			jMenuItem9.addActionListener(new java.awt.event.ActionListener() {
				public void actionPerformed(java.awt.event.ActionEvent e) {
					System.exit(0);
				}
			});
		}
		return jMenuItem9;
	}

	private void gerarRelatorioPorOrdemAlfabeticaAction() {
		try {
			RepRelatorio repRelatorio = this.interfaceUsuario.gerarRelatorio();
			repRelatorio.ordenarPorNome();
			Iterator iteRepRelatorio = repRelatorio.getIterator();
			Alocacao alocacao = null;
			if (repRelatorio.getVectorRelatorio().elementAt(0) != null) {
				Relatorio relatorio = null;

				JTextArea area = this.getJTextArea();
				area.setText("");

				while (iteRepRelatorio.hasNext()) {
					relatorio = (Relatorio) iteRepRelatorio.next();
					area.setText(area.getText() + "\n"
							+ relatorio.imprimirRelatorio());
				}
			} else {
				alertar("Nenhum docente cadastrado.");
			}
		} catch (Exception e) {
			this.alertar(e.getMessage());
		}
	}

	private void gerarRelatorioPorOrdemDosCreditosAction() {
		try {
			RepRelatorio repRelatorio = this.interfaceUsuario.gerarRelatorio();
			if (repRelatorio != null) {
				repRelatorio.ordenarPorCredito();
				Iterator iteRepRelatorio = repRelatorio.getIterator();
				Alocacao alocacao = null;
				if (repRelatorio.getVectorRelatorio().elementAt(0) != null) {
					Relatorio relatorio = null;
					this.getJTextArea().setText("");
					while (iteRepRelatorio.hasNext()) {
						relatorio = (Relatorio) iteRepRelatorio.next();
						this.getJTextArea().setText(
								this.getJTextArea().getText() + "\n"
										+ relatorio.imprimirRelatorio());
					}
				} else {
					alertar("Nenhum docente cadastrado.");
				}
			}

		} catch (Exception e) {
			this.alertar(e.getMessage());
		}
	}

	/**
	 * This method initializes jScrollPane
	 * 
	 * @return javax.swing.JScrollPane
	 */
	private JScrollPane getJScrollPane() {
		if (jScrollPane == null) {
			jScrollPane = new JScrollPane();
			jScrollPane.setViewportView(getJTextArea());
		}
		return jScrollPane;
	}

	public static void main(String[] args) {
		try {
			GuiCliente gui = new GuiCliente();
			gui.show();
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(1);
		}
	}

	/**
	 * This is the default constructor
	 */
	public GuiCliente() throws Exception {
		super();
		initialize();
		String name = "//localhost:5020/Fachada";
		this.interfaceUsuario = (IFachada) Naming.lookup(name);

	}

	/**
	 * This method initializes this
	 * 
	 * @return void
	 */
	private void initialize() {
		this.setLocation(50, 50);
		this.setJMenuBar(getJJMenuBar());
		this.setDefaultCloseOperation(javax.swing.JFrame.EXIT_ON_CLOSE);
		this.setSize(600, 400);
		this.setContentPane(getJContentPane());
		this.setTitle("Sistema de Alocação Docente do CIn");
	}

	/**
	 * This method initializes jContentPane
	 * 
	 * @return javax.swing.JPanel
	 */
	private javax.swing.JPanel getJContentPane() {
		if (jContentPane == null) {
			GridLayout gridLayout1 = new GridLayout();
			jContentPane = new javax.swing.JPanel();
			jContentPane.setLayout(gridLayout1);
			gridLayout1.setRows(1);
			gridLayout1.setColumns(1);
			jContentPane.add(getJScrollPane(), null);
		}
		return jContentPane;
	}

	private void alertar(String texto) {
		if (texto != null) {
			JOptionPane.showMessageDialog(this, texto, "Atenção",
					JOptionPane.WARNING_MESSAGE);
		}
	}
}