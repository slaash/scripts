
import java.io.FileReader;
import java.io.IOException;

import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.helpers.XMLReaderFactory;

class xml2csv extends DefaultHandler{

	public xml2csv(){
		super();
	}
	
	public static void main (String[] args) throws SAXException, IOException{
		String xmlfile;
		String csvfile;
		if (args.length==2){
			xmlfile=args[0];
			csvfile=args[1];
		}
		else{
			xmlfile="input.xml";
			csvfile="output.csv";
		}
		
		XMLReader xr=XMLReaderFactory.createXMLReader();
		xml2csv handler=new xml2csv();
		xr.setContentHandler(handler);
		xr.setErrorHandler(handler);
		
		FileReader r=new FileReader(xmlfile);
		xr.parse(new InputSource(r));
		
	}
	
    public void startDocument ()
    {
//    	System.out.println("Start document");
    }

    public void endDocument ()
    {
//    	System.out.println("End document");
    }
    
    public void startElement (String uri, String name, String qName, Attributes atts)
	{
//		if ("".equals (uri))
//			System.out.println("Start element: " + qName);
//		else
//			System.out.println("Start element: {" + uri + "}" + name);

//		if (qName=="ISSUE"){
    	int i;
//    	for (i=0;i<=atts.getLength();i++){
//				System.out.println(atts.);
//    	}
//		}
	}

    public void endElement (String uri, String name, String qName)
    {
//    	if ("".equals (uri))
////    		System.out.println("End element: " + qName);
//    	else
////    		System.out.println("End element:   {" + uri + "}" + name);
    }
	
    public void characters (char ch[], int start, int length)
    {
////	System.out.print("Characters:    \"");
//	for (int i = start; i < start + length; i++) {
//	    switch (ch[i]) {
//	    case '\\':
////		System.out.print("\\\\");
//		break;
//	    case '"':
////		System.out.print("\\\"");
//		break;
//	    case '\n':
////		System.out.print("\\n");
//		break;
//	    case '\r':
////		System.out.print("\\r");
//		break;
//	    case '\t':
////		System.out.print("\\t");
//		break;
//	    default:
//		System.out.print(ch[i]);
//		break;
//	    }
//	}
//	System.out.print("\"\n");
//    	System.out.println(ch);
    }

}