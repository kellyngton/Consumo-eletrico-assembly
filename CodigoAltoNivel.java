package projeto_Arquitetura1;

import javax.swing.JOptionPane;

/**
 * CALCULADORA DE CONSUMO ELETRICO
 *
 * @author kellyngton luiz da costa dias
 * @version 1.0
 * @since 30/03/2020 
 * TODO: While e/ou for 
 * if e/ou else 
 * input do usuário e escrita na tela
 * Propósito do programa
 */
public class CodigoAltoNivel {

    public static void main(String[] args) {
        int quantEletrodomestico = Integer.parseInt(JOptionPane.showInputDialog("Quantos eletrodomésticos deseja calcular o consumo?"));
        double consumoTotal = 0.0;
        if (quantEletrodomestico <= 0) {
            JOptionPane.showMessageDialog(null, "Número de eletrodomestico Impossivel");
        } else {
            do {
                double consumo = Double.parseDouble(JOptionPane.showInputDialog("Informe a potencia do aparelho"));
                int tempoFuncionamento = Integer.parseInt(JOptionPane.showInputDialog("Informe o tempo de uso diário deste aparelho"));
                double calculoMensal = ((consumo * tempoFuncionamento) * 30) / 100;
                consumoTotal += calculoMensal;
                quantEletrodomestico -= 1;
            } while (quantEletrodomestico > 0);
            JOptionPane.showMessageDialog(null, "O consumo mensal é de: " + consumoTotal);
        }
    }
}
