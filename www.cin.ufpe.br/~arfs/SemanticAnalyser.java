package suporte.analysis;

import java.util.Vector;

import org.sablecc.pascal.analysis.DepthFirstAdapter;
import org.sablecc.pascal.node.AIdentifierFactor;
import org.sablecc.pascal.node.AMinusUnaryOperator;
import org.sablecc.pascal.node.AMultipleFraseRead;
import org.sablecc.pascal.node.ANotUnaryOperator;
import org.sablecc.pascal.node.ANumberFactor;
import org.sablecc.pascal.node.APlusUnaryOperator;
import org.sablecc.pascal.node.AProgramHeading;
import org.sablecc.pascal.node.AReadSimpleStatement;
import org.sablecc.pascal.node.AReadlnSimpleStatement;
import org.sablecc.pascal.node.AStringFraseWrite;
import org.sablecc.pascal.node.AUnaryExpression;
import org.sablecc.pascal.node.AUniqueFraseRead;
import org.sablecc.pascal.node.AWritelnSimpleStatement;
import org.sablecc.pascal.node.PExpression;
import org.sablecc.pascal.node.PFactor;
import org.sablecc.pascal.node.PFraseRead;
import org.sablecc.pascal.node.PFraseWrite;
import org.sablecc.pascal.node.PProgramHeading;
import org.sablecc.pascal.node.PStructuredStatement;
import org.sablecc.pascal.node.PUnaryOperator;
import org.sablecc.pascal.node.TIdentifier;



public class SemanticAnalyser extends DepthFirstAdapter {
	
	private IdentificationTable table;
	
	private Vector<String> symbolsTemp;
	
	private Type type_temp;
	
	
	public void inAProgramHeading(AProgramHeading node) {
		//String nome = node.getIdentifier().getText();
		this.table.enter(node.toString(), new type_Program());
	}
	
	
	public void inAUnaryExpression (AUnaryExpression node){
		table.openScope();
		PFactor factor = node.getFactor();
		if (factor instanceof AIdentifierFactor){
			TIdentifier id = ((AIdentifierFactor) factor).getIdentifier();
			if (!table.isDeclared(id.getText())){
				throw new IllegalArgumentException("Não existe variável");
			}
		}
	}
	
	public void outAUnaryExpression (AUnaryExpression node){
		PUnaryOperator unaryOperator = node.getUnaryOperator();
		if(unaryOperator instanceof AMinusUnaryOperator){
			PFactor factor = node.getFactor();
			if (!(table.retrive(factor.toString()).type == Type_enum.INTEGER) && !(table.retrive(factor.toString()).type == Type_enum.REAL)){
				throw new IllegalArgumentException("Tipo incorreto...");
			}
			
		} else if (unaryOperator instanceof APlusUnaryOperator){
			PFactor factor = node.getFactor();
			if (!(table.retrive(factor.toString()).type == Type_enum.INTEGER) && !(table.retrive(factor.toString()).type == Type_enum.REAL)){
				throw new IllegalArgumentException("Tipo incorreto...");
			}
			
		} else if (unaryOperator instanceof ANotUnaryOperator){
			PFactor factor = node.getFactor();
			if (!(table.retrive(factor.toString()).type == Type_enum.BOOLEAN)){
				throw new IllegalArgumentException("Tipo incorreto...");
			}
		}
	table.closeScope();
	}
	
		
	public void inAReadlnSimpleStatement (AReadlnSimpleStatement node){
		table.openScope();
		PFraseRead frase = node.getFraseRead();
		if (frase instanceof AUniqueFraseRead){
			TIdentifier id = ((AUniqueFraseRead) frase).getIdentifier();
			if (!table.isDeclared(id.getText())){
				throw new IllegalArgumentException("Não existe variável");
			}
		}
	}
	
	/*public void outAReadlnSimpleStatement (AReadlnSimpleStatement node){
		PFraseRead frase = node.getFraseRead();
		if(frase instanceof AUniqueFraseRead){
			if (!(table.retrive(frase.toString()).type == ) && !(table.retrive(factor.toString()).type == Type_enum.REAL)){
				throw new IllegalArgumentException("Tipo incorreto...");
			}
			
		} else if (unaryOperator instanceof APlusUnaryOperator){
			PFactor factor = node.getFactor();
			if (!(table.retrive(factor.toString()).type == Type_enum.INTEGER) && !(table.retrive(factor.toString()).type == Type_enum.REAL)){
				throw new IllegalArgumentException("Tipo incorreto...");
			}
			
		} else if (unaryOperator instanceof ANotUnaryOperator){
			PFactor factor = node.getFactor();
			if (!(table.retrive(factor.toString()).type == Type_enum.BOOLEAN)){
				throw new IllegalArgumentException("Tipo incorreto...");
			}
		}
	
		
		
	table.closeScope();
	}
	*/
	public void inAReadSimpleStatement (AReadSimpleStatement node){
		table.openScope();
		PFraseRead frase = node.getFraseRead();
		if (frase instanceof AUniqueFraseRead){
			TIdentifier id = ((AUniqueFraseRead) frase).getIdentifier();
			if (!table.isDeclared(id.getText())){
				throw new IllegalArgumentException("Não existe variável");
			}
		} /*else if (frase instanceof AMultipleFraseRead){
			TIdentifier id = ((AMultipleFraseRead) frase).getIdentifier();
			if (!table.isDeclared(id.getText())){
				throw new IllegalArgumentException("Não existe variável");
			}
		}*/
	}
	
	
}

