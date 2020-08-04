package rmi;
import java.rmi.*;

public interface ServidorInt extends Remote {

	void imprimeMensagem(String mensagem) throws RemoteException;
}
