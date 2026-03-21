import Security

final class PasswordService {

    // Gera uma saida de Inteiros com base no ruido do hardware
    static func generateRandomBytes(_ count: Int, charsetCount: UInt8) -> [UInt8] {
        var tempBytes: [UInt8] = .init(repeating: 0, count: count * 2)
        var bytes: [UInt8] = .init(repeating: 0, count: count)
        var actualIndex: Int = bytes.startIndex
        var tempBytesIndex: Int = tempBytes.endIndex
        var status: Int32 = .zero

        while actualIndex < bytes.endIndex {
            if tempBytesIndex >= tempBytes.endIndex {
                status = SecRandomCopyBytes(kSecRandomDefault, tempBytes.count, &tempBytes)
                guard status == errSecSuccess else {
                    fatalError("Nao foi possivel gerar bytes do SecRandomCopyBytes")
                }
                tempBytesIndex = tempBytes.startIndex
            }

            if tempBytes[tempBytesIndex] < charsetCount {
                bytes[actualIndex] = tempBytes[tempBytesIndex]
                actualIndex = actualIndex.advanced(by: 1)
            }

            tempBytesIndex = tempBytesIndex.advanced(by: 1)
        }

        return bytes
    }

    // Calcula a entropia de uma entrada com base no total de caracteres
    static func calculateEntropy(_ length: Int, totalCharacters: Int) -> Double {
        return Double(length) * log2(Double(totalCharacters))
    }

    // Calcula o tempo (double) de brute force com base em uma entropia
    // Default: combinationsPerSecond: 1 bilhao de tentativas por segundo
    static func estimateBruteForce(_ entropy: Double, combinationsPerSecond: Double = 1e12)
        -> Double
    {
        let totalCombinations: Double = pow(2, entropy)
        return totalCombinations / combinationsPerSecond
    }

    // Gera a senha com base no charset e randomBytes
    // INFO: Nao verifica se o randomByte eh valido dentro do charset
    static func generatePassword(_ length: Int, charset: [Character], randomBytes: [UInt8])
        -> String
    {
        guard randomBytes.count >= length else {
            fatalError("Array de randomBytes menor que o tamanho da entrada")
        }

        var result: String = ""
        result.reserveCapacity(length)

        for i: Int in 0..<length {
            result.append(charset[Int(randomBytes[i])])
        }
        return result
    }
}
