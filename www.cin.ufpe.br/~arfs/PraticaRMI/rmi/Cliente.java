package rmi;
import java.rmi.*;
import java.io.*;

public class Cliente implements Serializable {

public static void main(String args[]) {
    try {
      ServidorInt s = (ServidorInt) Naming.lookup("servidor");
      s.imprimeMensagem("Hello CIn!");
    }
    catch (Exception e) {
      System.out.println("Erro: Mensagem: " + e.getMessage());
      e.printStackTrace();
    }
  }}
