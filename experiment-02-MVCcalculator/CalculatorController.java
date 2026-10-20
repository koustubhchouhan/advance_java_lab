import java.awt.event.*; 
public class CalculatorController implements ActionListener {    
    Views view;    
    Model model;    
    public CalculatorController(Views view,                                
        Model model) {        
            this.view=view;        
            this.model=model;        
            registerListeners();    
        }
    
    private void registerListeners() {
        view.add.addActionListener(this);        
        view.sub.addActionListener(this);        
        view.mul.addActionListener(this);        
        view.div.addActionListener(this);
    }    
        @Override    
        public void actionPerformed(ActionEvent e) {        
            double a=Double.parseDouble(view.a.getText());        
            double b=Double.parseDouble(view.b.getText());        
            double result=0;        
            if(e.getSource()==view.add)            
                result=model.add(a,b);        
            else if(e.getSource()==view.sub)            
                result=model.sub(a,b);        
            else if(e.getSource()==view.mul)            
                result=model.mul(a,b);        
            else if(e.getSource()==view.div)            
                result=model.div(a,b);        
            view.txtresult.setText(String.valueOf(result));    
        } 
    }