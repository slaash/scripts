import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JMenuBar;
import javax.swing.JMenu;
import javax.swing.JMenuItem;
import javax.swing.JTextField;
import java.awt.GridLayout;


class sWindow extends JFrame implements ActionListener{
	
	public JMenu createFileMenu(){
		JMenu menu;
		JMenuItem menuOpen, menuExit;
		menu = new JMenu("File");
		
		menuOpen = new JMenuItem("Open");
		menuOpen.addActionListener((ActionListener) this);
		menu.add(menuOpen);
		menuExit = new JMenuItem("Exit");
		menuOpen.addActionListener((ActionListener) this);
		menu.add(menuExit);		
		
		return menu;
	}
	
	public JMenu createHelpMenu(){
		JMenu menu;
		JMenuItem menuItem;
		menu = new JMenu("Help");
		
		menuItem = new JMenuItem("Help");
		menu.add(menuItem);
		menuItem = new JMenuItem("About");
		menu.add(menuItem);		
		
		return menu;
	}
	
//	public JLabel setLabel(){
//		JLabel label1=new JLabel("Label1");
//		label1.setHorizontalTextPosition(JLabel.NORTH_EAST);
//		return label1;
//	}
	
	public void actionPerformed(ActionEvent e) {
//		JMenuItem source = (JMenuItem) (e.getSource());
//		String s = "Menu Item source: " + source.getText();
//		JLabel label1=new JLabel(s);
//		label1.setHorizontalTextPosition(JLabel.NORTH_EAST);
//		add(label1);
	}
	
	sWindow(){
		JMenuBar mainMenuBar;
		JTextField stField,endField;
		JLabel stLabel,endLabel;
		
		//2 columns, rows not defined
		GridLayout myLayout = new GridLayout(0,2);
		setLayout(myLayout);
		
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setSize(800,600);
		
		mainMenuBar = new JMenuBar();
		mainMenuBar.add(createFileMenu());
		mainMenuBar.add(createHelpMenu());

		setJMenuBar(mainMenuBar);
		
		stLabel=new JLabel("Start from:");
		stField = new JTextField("aaa",10);

		endLabel=new JLabel("End at:");
		endField = new JTextField("bbb",10);

		add(stLabel);
		add(stField);
		add(endLabel);
		add(endField);
//		add(setLabel());
		
		//last things?...
		setVisible(true);
	}
	
	public static void main (String[] args){

		new sWindow();
		
	}
}