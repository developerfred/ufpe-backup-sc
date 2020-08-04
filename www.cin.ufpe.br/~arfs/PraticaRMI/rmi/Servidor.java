package rmi;
import java.rmi.*;
import java.rmi.server.*;
import sun.rmi.registry.RegistryImpl;

public class Servidor extends UnicastRemoteObject implements ServidorInt {
	
	public Servidor() throws RemoteException {
		super();
		RegistryImpl impl = new RegistryImpl(1099);
	}

	public void imprimeMensagem(String mensagem) {
		System.out.println("A mensagem enviada foi : " + mensagem);
	}

	public static void main(String args[]) {
		try {
			Servidor s = new Servidor();
			Naming.rebind("servidor", s);
			System.out.println("Servidor Registrado");
		} catch (Exception e) {
			System.out.println("Erro : Mensagem : " + e.getMessage());
			e.printStackTrace();
		}
	}
}
