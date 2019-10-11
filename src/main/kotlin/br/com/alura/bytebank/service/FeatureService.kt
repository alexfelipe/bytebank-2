package br.com.alura.bytebank.service

import br.com.alura.bytebank.model.Feature
import br.com.alura.bytebank.repository.FeaturesRepository
import org.springframework.stereotype.Service

@Service
class FeatureService(private val repository: FeaturesRepository) {

    fun todas() = repository.findAll().toList()

    fun salva(feature: Feature) = repository.save(feature);

}