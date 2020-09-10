package com.controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.controllers.chefDepartement.ConsulterDemandesChefDepartement;
import com.controllers.chefDepartement.ConsulterSeancesChefDepartement;
import com.controllers.etudiant.ConsulterReleverAbsencesEtudiant;
import com.dots.Dot_Login;
import com.helpers.AbsenceDepartementResponse;
import com.helpers.DemandeChangementSeanceResponse;
import com.helpers.DemandeCongeAcademiqueResponse;
import com.helpers.DemandeSeanceSuppResponse;
import com.helpers.DemandesDepartementResponse;
import com.helpers.LoginResponse;
import com.helpers.RequestResponse;
import com.helpers.SeanceDepartementResponse;
import com.modele.Admin;
import com.modele.ChefDepartement;
import com.modele.Enseignant;
import com.modele.Etudiant;
import com.modele.ResponsableFormation;
import com.modele.Seance.Etat_Demande;
import com.modele.Utilisateur;
import com.utility.ReleverAbsencesEtudiant;

@WebServlet("/Login")
public class Login extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	public Login()
	{
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession();
		String message = null;
		String user = request.getParameter("username").toString().toLowerCase();
		String pass = request.getParameter("password").toString();
		boolean keepLogged = request.getParameter("keepLogged") == null ? false : true;

		Client client = ClientBuilder.newClient();
		WebTarget target = client.target("http://localhost:8080/SmartUniversity-API/api/auth");
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.post(Entity.json(new Dot_Login(user, pass, false)));
		apiResponse.bufferEntity();
		RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);

		if (requestResponse == null)
		{
			if (keepLogged)
			{
				Cookie cookie = new Cookie("JSESSIONID", session.getId());
				cookie.setMaxAge(Integer.MAX_VALUE);
				response.addCookie(cookie);
			}
			LoginResponse loginResponse = apiResponse.readEntity(LoginResponse.class);

			session.setAttribute("token", loginResponse.getToken());
			target = client.target("http://localhost:8080/SmartUniversity-API/api/get/user/" + loginResponse.getId());
			apiResponse = target.request(MediaType.APPLICATION_JSON)
					.header(HttpHeaders.AUTHORIZATION, "Bearer " + session.getAttribute("token").toString()).get();
			apiResponse.bufferEntity();

			requestResponse = RequestResponse.GetRequestResponse(apiResponse);
			if (requestResponse == null)
			{
				Utilisateur utilisateur = apiResponse.readEntity(Utilisateur.class);

				switch (utilisateur.getUser_type())
				{
				case enseignant:
					Enseignant enseignant = apiResponse.readEntity(Enseignant.class);
					session.setAttribute("utilisateur", enseignant);
					Redirect.SendRedirect(request, response, "/WEB-INF/espace_enseignant/index_enseignant.jsp");
					return;
				case chefDepartement:
					ChefDepartement chefDepartement = apiResponse.readEntity(ChefDepartement.class);
					session.setAttribute("utilisateur", chefDepartement);
					SetSeancesSansEnseignant(session);
					SetDemandesNonTraite(session);
					Redirect.SendRedirect(request, response,
							"/WEB-INF/espace_enseignant/espace_chef_departement/index_chef_departement.jsp");
					return;
				case etudiant:
					Etudiant etudiant = apiResponse.readEntity(Etudiant.class);
					session.setAttribute("utilisateur", etudiant);
					SetAbsencesNonJustifier(session);
					SetHasCongeAcademique(session);
					SetAbsencesNonTraite(session);
					Redirect.SendRedirect(request, response, "/WEB-INF/espace_etudiant/index_etudiant.jsp");
					break;
				case admin:
					Admin admin = apiResponse.readEntity(Admin.class);
					session.setAttribute("utilisateur", admin);
					Redirect.SendRedirect(request, response, "/WEB-INF/espace_admin/index_admin.jsp");
					break;
				case responsableFormation:
					ResponsableFormation responsableFormation = apiResponse.readEntity(ResponsableFormation.class);
					session.setAttribute("utilisateur", responsableFormation);
					Redirect.SendRedirect(request, response,
							"/WEB-INF/espace_enseignant/espace_responsable_formation/index_responsable_formation.jsp");
					break;
				default:
					break;
				}

			} else
			{
				Redirect.SendRedirect(request, response, "login.jsp");
				return;
			}

			apiResponse.close();
		} else
		{
			message = requestResponse.getMessage_fr();
			session.setAttribute("message", message);
			Redirect.SendRedirect(request, response, "login.jsp");
			return;
		}
	}

	@SuppressWarnings("unchecked")
	public static void SetSeancesSansEnseignant(HttpSession session)
	{
		ConsulterSeancesChefDepartement.UpdateSeancesDepartementFromAPI(session);

		ArrayList<SeanceDepartementResponse> seances = (ArrayList<SeanceDepartementResponse>) session
				.getAttribute("seancesDepartement");

		if (seances == null || seances.size() == 0)
		{
			session.setAttribute("seancesSansEnseignant", 0);
			return;
		}

		int result = 0;

		for (SeanceDepartementResponse seance : seances)
		{
			if (seance.getEnseignant() == null)
			{
				result++;
			}
		}

		session.setAttribute("seancesSansEnseignant", result);
	}

	public static void SetDemandesNonTraite(HttpSession session)
	{
		ConsulterDemandesChefDepartement.UpdateDemandesFromAPI(session);

		DemandesDepartementResponse demandes = (DemandesDepartementResponse) session
				.getAttribute("demandesDepartement");

		if (demandes == null)
		{
			session.setAttribute("demandesNonTraite", 0);
			return;
		}

		int result = 0;

		if (!(demandes.getDemandesChangementSeanceResponse() == null))
		{
			for (DemandeChangementSeanceResponse demande : demandes.getDemandesChangementSeanceResponse())
			{
				if (demande.getChangementSeance().getEtat_seance() == Etat_Demande.nonTraite)
				{
					result++;
				}
			}
		}

		if (!(demandes.getDemandesSeanceSuppResponse() == null))
		{
			for (DemandeSeanceSuppResponse demande : demandes.getDemandesSeanceSuppResponse())
			{
				if (demande.getSeanceSupp().getEtat_seance() == Etat_Demande.nonTraite)
				{
					result++;
				}
			}
		}

		if (!(demandes.getDemandesCongeAcademiqueResponse() == null))
		{
			for (DemandeCongeAcademiqueResponse demande : demandes.getDemandesCongeAcademiqueResponse())
			{
				if (demande.getCongeAcademique().getEtat_demande() == Etat_Demande.nonTraite)
				{
					result++;
				}
			}
		}
		session.setAttribute("demandesNonTraite", result);
	}

	public static void SetAbsencesNonJustifier(HttpSession session)
	{
		ConsulterReleverAbsencesEtudiant.UpdateReleverAbsencesFromAPI(session);

		ReleverAbsencesEtudiant relever = (ReleverAbsencesEtudiant) session.getAttribute("releverAbsences");

		if (relever == null)
		{
			session.setAttribute("absencesNonJustifier", 0);
			return;
		}

		int result = 0;

		
		if(!(relever.getRelever() == null))
		{
			for (ArrayList<AbsenceDepartementResponse> absences : relever.getRelever().values())
			{
				for (AbsenceDepartementResponse absence : absences)
				{
					if (absence.isJustifiable() == true)
					{
						result++;
					}
				}
			}
		}
		session.setAttribute("absencesNonJustifier", result);
	}
	
	public static void SetAbsencesNonTraite(HttpSession session)
	{
		ConsulterReleverAbsencesEtudiant.UpdateReleverAbsencesFromAPI(session);

		ReleverAbsencesEtudiant relever = (ReleverAbsencesEtudiant) session.getAttribute("releverAbsences");

		if (relever == null)
		{
			session.setAttribute("absencesNonTraite", 0);
			return;
		}

		int result = 0;

		
		if(!(relever.getRelever() == null))
		{
			for (ArrayList<AbsenceDepartementResponse> absences : relever.getRelever().values())
			{
				for (AbsenceDepartementResponse absence : absences)
				{
					if (absence.getLatestJustification() != null && absence.getLatestJustification().getEtat_justification() == Etat_Demande.nonTraite)
					{
						result++;
					}
				}
			}
		}
		session.setAttribute("absencesNonTraite", result);
	}

	public static void SetHasCongeAcademique(HttpSession session)
	{
		String token = session.getAttribute("token").toString();
		Etudiant etudiant = (Etudiant) session.getAttribute("utilisateur");

		Client client = ClientBuilder.newClient();
		WebTarget target = client.target("http://localhost:8080/SmartUniversity-API/api/get/demande/etudiant")
				.queryParam("id_etudiant", etudiant.getId_utilisateur());
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).get();
		apiResponse.bufferEntity();
		RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);

		if (requestResponse == null)
		{
			session.setAttribute("HasCongeAcademique", true);
		} else
		{
			session.setAttribute("HasCongeAcademique", false);
		}
	}
}
