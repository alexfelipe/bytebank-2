package br.com.alura.bytebank.service

import br.com.alura.bytebank.model.Transferencia
import br.com.alura.bytebank.repository.TransferenciaRepository
import org.springframework.stereotype.Service

@Service
class TransferenciaService(private val repository: TransferenciaRepository) {

    fun todas() = repository.findAll().toList()

    fun salva(transferencia: Transferencia) = repository.save(transferencia)

}