package br.com.alura.bytebank.model

import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Component

@Component
class ValidadorSenha {

    @Value("\${user.password}")
    private lateinit var applicationSenha: String

    fun valida(senha: String) = senha == applicationSenha

}
