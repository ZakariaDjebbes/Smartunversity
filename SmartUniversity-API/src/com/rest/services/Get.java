package com.rest.services;

import java.util.ArrayList;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.data.DAO_Absence;
import com.data.DAO_ChangementSeance;
import com.data.DAO_Enseignant;
import com.data.DAO_Etudiant;
import com.data.DAO_Justification;
import com.data.DAO_Module;
import com.data.DAO_Seance;
import com.data.DAO_SeanceSupp;
import com.data.DAO_User;
import com.helpers.AbsenceResponse;
import com.helpers.EtudiantResponse;
import com.helpers.RequestReponse;
import com.helpers.SeanceResponse;
import com.helpers.Utility;
import com.modele.Absence;
import com.modele.ChangementSeance;
import com.modele.Etudiant;
import com.modele.Etudiant.Annee;
import com.modele.Etudiant.Specialite;
import com.modele.Justification;
import com.modele.Module;
import com.modele.Seance;
import com.modele.SeanceSupp;
import com.modele.Utilisateur;
import com.rest.annotations.Secured;
import com.rest.exceptions.RequestNotValidException;

@Path("/get")
public class Get
{
	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/user/{id}")
	public Response GetUserByID(@PathParam("id") int id)
	{
		Utilisateur utilisateur = DAO_User.GetUserByID(id);
		
		if(utilisateur == null)
		{
			throw new RequestNotValidException(Status.NOT_FOUND, new RequestReponse("Cannot find a user with this ID"));
		}
		
		switch (utilisateur.getUser_type())
		{
		case enseignant:
			utilisateur = DAO_Enseignant.GetEnseignant(utilisateur);
			break;

		default:
			break;
		}
		
		return Utility.Response(Status.OK, utilisateur);
	}

	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/seances/{id}")
	public Response GetSeancesEnseignant(@PathParam("id") int id)
	{
		ArrayList<Seance> seances = DAO_Seance.GetSeancesEnseignantByID(id);
		
		if(seances.size() == 0)
		{
			return Utility.Response(Status.NOT_FOUND, new RequestReponse("Couldn't find seances matching this teacher ID"));
		}
		
		return Utility.Response(Status.OK, seances);
	}
	
	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/seances/full/{id_enseignant}")
	public Response GetSeancesCompleteEnseignant(@PathParam("id_enseignant") int id_enseignant)
	{
		ArrayList<SeanceResponse> response = new ArrayList<SeanceResponse>();
		
		ArrayList<Seance> seances = DAO_Seance.GetSeancesEnseignantByID(id_enseignant);
		
		if(seances.size() == 0)
		{
			return Utility.Response(Status.NOT_FOUND, new RequestReponse("Couldn't find seances matching this teacher ID"));
		}
		
		for (Seance seance : seances)
		{
			SeanceResponse seanceResponse = new SeanceResponse();
			seanceResponse.setSeance(seance);
			
			//getting the module of seance
			Module module = DAO_Module.GetMouleByCode(seance.getCode_module());
			
			if(module == null)
			{	//if no module for this seance is found and error should be thrown
				return Utility.Response(Status.NOT_FOUND, new RequestReponse("An internal error has occured, a seance is missing its module code"));	
			}
			
			seanceResponse.setModule(module);
			
			//getting changement demand is it exists
			ChangementSeance changementSeance = DAO_ChangementSeance.GetChangementSeance(seance.getCode_seance());
			
			//if it exists its sent, else send nothing...
			if(changementSeance != null)
			{
				seanceResponse.setChangementSeance(changementSeance);
			}
			
			//getting seances supp
			ArrayList<SeanceSupp> seancesSupp = DAO_SeanceSupp.GetSeancesSupp(seance.getCode_seance());
			
			if(seancesSupp.size() == 0)
			{
				seancesSupp = null;
			}
			
			
			seanceResponse.setSeancesSupp(seancesSupp);
			
			//getting students of this seance
			ArrayList<EtudiantResponse> etudiantsResponse = new ArrayList<EtudiantResponse>();
			ArrayList<Etudiant> etudiants = new ArrayList<Etudiant>();
			
			etudiants = DAO_Etudiant.GetEtudiants(seance.getAnnee(), seance.getSpecialite(), seance.getGroupe());
			
			//a seance without students is technically possible
			
			if(etudiants.size() == 0)
			{
				//an empty list shouldn't be created for studens, nothing is sent
				etudiants = null;
			}
			else 
			{
				//foreach student, get the absences
				for (Etudiant etudiant : etudiants)
				{
					EtudiantResponse etudiantResponse = new EtudiantResponse();
					etudiantResponse.setEtudiant(etudiant);
					
					//getting absences
					ArrayList<Absence> absences = DAO_Absence.GetAbsencesOfStudentBySeance(seance.getCode_seance(), etudiant.getId_utilisateur());
					
					//a student may have 0 absences
					//if 0 absences nothing should be sent in the json response
					if(absences.size() == 0)
					{
						absences = null;
					}
					else 
					{
						//getting justifications
						ArrayList<AbsenceResponse> absencesResponse = new ArrayList<AbsenceResponse>();
						
						int absencesNonJustifier = 0;
						int absencesJustifier = 0;
						//foreach absence get justifications
						for (Absence absence : absences)
						{
							AbsenceResponse absenceResponse = new AbsenceResponse();
							absenceResponse.setAbsence(absence);
							
							Justification justification = DAO_Justification.GetJustificationByAbsence(absence.getNumero_absence());
							
							if(justification != null)
							{
								absencesJustifier++;
								absenceResponse.setJustification(justification);
								absenceResponse.setJustifier(true);
							}
							else 
							{
								absencesNonJustifier++;
								absenceResponse.setJustification(null);
								absenceResponse.setJustifier(false);
							}
							absencesResponse.add(absenceResponse);
						}
						
						//if 3 absences, excluded >>> TODO update this
						if(absencesNonJustifier >= 3 || absences.size() >= 5)
						{
							etudiantResponse.setExclus(true);
						}
						else
						{
							etudiantResponse.setExclus(false);	
						}
						
						//setting the absences numbers
						etudiantResponse.setNombreAbsences(absencesResponse.size());
						etudiantResponse.setAbsencesJusifiter(absencesJustifier);
						etudiantResponse.setAbsencesNonJustifier(absencesNonJustifier);
						
						//setting the absences data
						etudiantResponse.setAbsences(absencesResponse);
					}
					//set the sudent
					etudiantsResponse.add(etudiantResponse);
				}
				//set the students..
				seanceResponse.setEtudiants(etudiantsResponse);
			}
			response.add(seanceResponse);	
		}
		
		return Utility.Response(Status.OK, response);
	}
	
	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/module/{code_module}")
	public Response GetModule(@PathParam("code_module") String code_module)
	{
		Module module = DAO_Module.GetMouleByCode(code_module);
		
		if(module == null)
		{
			return Utility.Response(Status.NOT_FOUND, new RequestReponse("Couldn't find a module for this code module"));
		}
		else 
		{
			return Utility.Response(Status.OK, module);
		}
	}
	
	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/etudiants")
	public Response GetEtudiantsOfSeance(@QueryParam("annee") Annee annee, @QueryParam("specialite") Specialite specialite, @QueryParam("groupe") int groupe)
	{
		ArrayList<Etudiant> etudiants = DAO_Etudiant.GetEtudiants(annee, specialite, groupe);
		
		if(etudiants.size() == 0)
		{
			return Utility.Response(Status.NOT_FOUND, new RequestReponse("Couldn't find any student for this year, speciality and group"));
		}
		
		return Utility.Response(Status.OK, etudiants);
	}
	
//	@GET
//	@Secured
//	@Produces(MediaType.APPLICATION_JSON)
//	@Path("absences")
//	public Response GetAbsencesBySeance(@QueryParam("code_seance")String code_seance)
//	{
//		ArrayList<Absence> absences = DAO_Absence.GetAbsencesOfSeance(code_seance);
//		
//		if(absences.size() == 0)
//		{
//			return Utility.Response(Status.NOT_FOUND, new RequestReponse("Couldn't find any result for the requested query"));
//		}
//		
//		return Utility.Response(Status.OK, absences);
//	}

	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/absences")
	public Response GetAbsencesByEtudiant(@QueryParam("code_seance")String code_seance, @QueryParam("id_etudiant") int id_etudiant)
	{
		ArrayList<Absence> absences = DAO_Absence.GetAbsencesOfStudentBySeance(code_seance, id_etudiant);
		
		if(absences.size() == 0)
		{
			return Utility.Response(Status.NOT_FOUND, new RequestReponse("Couldn't find any absence for the requested student"));
		}
		
		return Utility.Response(Status.OK, absences);
	}
}