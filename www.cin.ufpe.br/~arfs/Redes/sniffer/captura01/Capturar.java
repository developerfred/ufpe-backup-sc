package captura01;

import java.io.IOException;
import java.net.NetworkInterface;

import jpcap.JpcapCaptor;
import jpcap.PacketReceiver;
import jpcap.packet.*;


public class Capturar {

	
	private static final PacketReceiver handler = null;


		
	
	public static void main(String args[]) throws IOException{
				
		jpcap.NetworkInterface device = JpcapCaptor.getDeviceList()[0];//[Integer.parseInt(args[0])];
		
		JpcapCaptor captor = JpcapCaptor.openDevice(device,2000,false,5000);
		
		captor.processPacket(-1, handler);
		
				

		
	}

}
