package pacote01;

import java.io.IOException;
import java.net.NetworkInterface;
import java.util.ArrayList;
import java.util.List;

import jpcap.JpcapCaptor;
import jpcap.PacketReceiver;
import jpcap.packet.*;


public class Capturar {

	private Packet pacote;
    private JpcapCaptor captor;
    private List<Packet> pacotes = new ArrayList<Packet>();

	public Capturar(){
		pacote = new Packet();
                jpcap.NetworkInterface[] devices = JpcapCaptor.getDeviceList();
        try {
            captor = JpcapCaptor.openDevice(devices[0], 65536, false,6000);
        } catch (IOException ex) {
            ex.printStackTrace();
        }

	}

	public Packet getPacote() {
		return pacote;
	}


	public void setPacote(Packet pacote) {
		this.pacote = pacote;
	}

    public Packet capturarPacotes(){
         Packet p = captor.getPacket();
       	return p;
    }

    public String obterDados(List<Packet> listPack){
    	String dados = "";
    	for(Packet p : listPack){
    		byte[] data = p.data;

    		for(int aux = 0; aux < data.length; aux++){
        		dados = dados + ((char)(data[aux]));
    		}

    	}

/*    	String dados = "";
    	byte[] data = captor.getPacket().data;

    	for(int aux = 0; aux < data.length; aux++){
    		dados = dados + ((char)(data[aux]));
		}*/
    	return dados;
    }
    public String obterCabecalho(){

    	String dados = "";
    	byte[] data = captor.getPacket().header;

    	for(int aux = 0; aux < data.length; aux++){
    		dados = dados + ((data[aux]));
		}
    	return dados;

    }


	public static void main(String args[]) throws IOException{

		Capturar cap = new Capturar();


		byte[] dados;
		while(true){

			cap.captor.setFilter("ip", true);
			cap.pacote = cap.captor.getPacket();

			System.out.println(cap.pacote);
//			
			System.out.println(cap.obterCabecalho());
			System.out.println();

		}




	}

	public JpcapCaptor getCaptor() {
		return captor;
	}

	public void setCaptor(JpcapCaptor captor) {
		this.captor = captor;
	}

	public List<Packet> getPacotes() {
		return pacotes;
	}

	public void setPacotes(List<Packet> pacotes) {
		this.pacotes = pacotes;
	}

}
