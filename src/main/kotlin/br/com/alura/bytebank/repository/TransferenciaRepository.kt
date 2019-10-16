package br.com.alura.bytebank.repository

import br.com.alura.bytebank.model.Transferencia
import org.springframework.data.repository.PagingAndSortingRepository
import org.springframework.stereotype.Repository

@Repository
interface TransferenciaRepository : PagingAndSortingRepository<Transferencia, String> {
    fun findAllByOrderByDataAsc(): List<Transferencia>
}
