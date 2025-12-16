
import SwiftUI

// MARK: - Enum Tính toán
enum OperatorType{
    case add
    case subtract
    case multiply
    case divide
    
    var symbol : String{
        switch self {
        case .add: return "+"
        case .subtract: return "-"
        case .multiply: return "×"
        case .divide: return "÷"
        }
    }
    var color: Color{
        switch self{
        case .add: return .red
        case .subtract: return .orange
        case .multiply: return .purple
        case .divide: return .black
        }
    }
    
}

// MARK: - Main View
struct Practice03View: View {
    @State private var number1: String = ""
    @State private var number2: String = ""
    @State private var selectedOperator: OperatorType? = nil
    @State private var result: Double? = nil
    var body: some View {
        VStack(spacing: 20){
            Spacer()
            
            //Title
            Text("Thực hành 03")
                .font(.title2)
                .fontWeight(.semibold)
            
            //Input1
            TextField("Nhập số thứ nhất", text: $number1)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            //Operator button
            HStack(spacing: 16){
                operatorButton(.add)
                operatorButton(.subtract)
                operatorButton(.multiply)
                operatorButton(.divide)
            }
            
            //Input 2
            TextField("Nhập số thứ hai", text: $number2)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            //Result
            Text("Kết quả: \(resultText)")
                .font(.headline)
                .padding(.top, 8)
            
            Spacer()
        }
        .onChange(of: number1) {
            calculate()
        }
        .onChange(of: number2) {
            calculate()
        }
        .onChange(of: selectedOperator) {
            calculate()
        }
    }
    private func operatorButton(_ op: OperatorType) -> some View{
        Button{
            if selectedOperator == op{
                selectedOperator = nil
            }else{
                selectedOperator = op
            }
        } label: {
            Text(op.symbol)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(op.color)
                        .opacity(selectedOperator == op ? 1 : 0.5)
                )
        }
    }
    
    //MARK: - Logic
    private func calculate(){
        guard
            let a = Double(number1),
            let b = Double(number2),
            let op = selectedOperator
        else{
            result = nil
            return
        }
        switch op{
        case .add:
            result = a + b
        case .subtract:
            result = a - b
        case .multiply:
            result = a * b
        case .divide:
            result = b == 0 ? nil : a / b
        }
    }
    
    //MARK: - Result Text
    private let formatter: NumberFormatter = {
        let f = NumberFormatter()
        f.minimumFractionDigits = 0
        f.maximumFractionDigits = 2
        return f
    }()

    private var resultText: String {
        if let value = result {
            return formatter.string(from: NSNumber(value: value)) ?? "--"
        }
        return "--"
    }

}

//MARK: - Preview
#Preview {
    Practice03View()
}
