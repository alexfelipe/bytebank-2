package br.com.alura.bytebank.dto

import br.com.alura.bytebank.model.Feature

class FeatureRequisicao(
        val id: Long,
        val nome: String,
        val disponivel: Boolean,
        val feature: Feature = Feature(
                id = id,
                nome = nome,
                disponivel = disponivel
        )
)

class FeatureResposta(feature: Feature,
                      val id: Long = feature.id,
                      val nome: String = feature.nome)