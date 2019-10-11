package br.com.alura.bytebank.dto

import br.com.alura.bytebank.model.Feature
import java.util.*

class FeatureRequisicao(
        val id: String = UUID.randomUUID().toString(),
        val nome: String,
        val disponivel: Boolean,
        val feature: Feature = Feature(
                id = id,
                nome = nome,
                disponivel = disponivel
        )
)

class FeatureResposta(feature: Feature,
                      val id: String = feature.id,
                      val nome: String = feature.nome,
                      val disponivel: Boolean = feature.disponivel)